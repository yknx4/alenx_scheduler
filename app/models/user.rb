class User < ApplicationRecord
  attr_accessor :role, :subdomain

  scope :users, -> { distinct.with_role :user}
  scope :admins, -> { distinct.with_role :admin}
  scope :providers, -> { distinct.with_role :provider}

  after_initialize :assign_inital_role
  after_validation :setup_tenant, only: [:create], if: :require_setup_tenant?
  after_commit :update_role

  rolify

  has_many :users_roles
  has_many :roles, through: :users_roles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  belongs_to :tenant
  validates_presence_of :tenant, if: :tenant_required?
  validates_presence_of :subdomain, if: :subdomain_required?
  validates_presence_of :role, if: :new_record?

  validate :tenant_is_not_taken

  def admin?
    role == 'admin'
  end

  def assign_inital_role
    self.role ||= initial_role
  end

  def setup_tenant
    if role == 'admin' and errors[:tenant].empty?
      self.tenant = Tenant.create! subdomain: self.subdomain
      Apartment::Tenant.switch!(self.subdomain)
    else
      self.tenant = Tenant.find_by subdomain: self.subdomain
    end

    Rails.application.routes.default_url_options[:host] = self.subdomain + '.example.com' if Rails.env.test?
  end

  alias_method :role_setter, :role=
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
    self.subdomain.present? and (self.tenant.blank? or errors.present?)
  end

  def tenant_is_not_taken
    return unless admin?
    if subdomain_taken?
      errors[:tenant] << 'already exists.'
    end
  end

  def subdomain_taken?
    Tenant.where(subdomain: subdomain).exists?
  end

end
