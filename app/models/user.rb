class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  include RequiresSchedule

  attr_accessor :role, :subdomain

  scope :users, -> { distinct.with_role :user }
  scope :admins, -> { distinct.with_role :admin }
  scope :providers, -> { distinct.with_role :provider }

  after_initialize :assign_inital_values
  after_validation :setup_tenant, only: [:create], if: :require_setup_tenant?
  after_commit :update_role

  rolify

  has_many :users_roles
  has_many :roles, through: :users_roles
  has_many :user_services
  has_many :services, through: :user_services
  has_many :user_appointments, class_name: 'Appointment', foreign_key: 'user_id'
  has_many :provider_appointments, class_name: 'Appointment', foreign_key: 'provider_id'

  belongs_to :tenant
  belongs_to :schedule

  validates :schedule, presence: { if: :provider? }
  validates :tenant, presence: { if: :tenant_required? }
  validates :subdomain, presence: { if: :subdomain_required? }
  validates :role, presence: { if: :new_record? }
  validates_absence_of :services, unless: :provider?
  validates_with UserValidator

  def admin?
    role == 'admin'
  end

  def provider?
    role == 'provider'
  end

  def appointments
    if provider?
      provider_appointments
    else
      user_appointments
    end
  end

  def assign_inital_values
    self.role ||= initial_role
    self.tenant ||= Tenant.current
  end

  def setup_tenant
    return unless errors[:tenant].empty?
    if admin?
      setup_tenant = Tenant.create! subdomain: subdomain
      Apartment::Tenant.switch!(subdomain)
    else
      setup_tenant = Tenant.find_by subdomain: subdomain
    end

    self.tenant = setup_tenant

    set_test_host
  end

  def set_test_host
    Rails.application.routes.default_url_options[:host] = subdomain + '.example.com' if Rails.env.test?
  end

  alias role_setter role=
  def role=(value)
    if %w(user provider admin).include?(value)
      role_setter value
    else
      role_setter 'user'
    end
  end

  def initial_role
    roles.exists? ? roles.first.name : 'user'
  end

  alias subdomain_getter subdomain
  def subdomain
    if tenant.present?
      tenant.subdomain
    else
      subdomain_getter
    end
  end

  private

  def update_role
    return if has_role?(role)
    roles.destroy_all
    add_role(role)
  end

  def subdomain_required?
    new_record? and tenant.blank?
  end

  def tenant_required?
    new_record? and subdomain.blank?
  end

  def require_setup_tenant?
    subdomain.present? and (self.tenant.blank? || errors.present?)
  end
end
