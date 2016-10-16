class User < ApplicationRecord
  attr_accessor :role, :subdomain

  scope :users, -> { distinct.with_role :user}
  scope :admins, -> { distinct.with_role :admin}
  scope :providers, -> { distinct.with_role :provider}

  # After Create
  after_create :assign_inital_role
  after_validation :setup_tenant, only: [:create], if: :require_setup_tenant?

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

  def assign_inital_role
    self.add_role(role) if self.roles.blank?
  end

  def setup_tenant
    if role == 'admin'
      self.tenant = Tenant.create! subdomain: self.subdomain
    else
      self.tenant = Tenant.find_by subdomain: self.subdomain
    end
  end

  alias_method :setted_role, :role
  def role
    %w(user provider admin).include?(setted_role) ? setted_role : 'user'
  end

  private
  def subdomain_required?
    new_record? and tenant.blank?
  end

  def tenant_required?
    new_record? and subdomain.blank?
  end

  def require_setup_tenant?
    self.tenant.blank? or errors.present?
  end

end
