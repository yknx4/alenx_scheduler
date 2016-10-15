class User < ApplicationRecord
  attr_accessor :role, :subdomain

  scope :users, -> { distinct.with_role :user}
  scope :admins, -> { distinct.with_role :admin}
  scope :providers, -> { distinct.with_role :provider}

  # After Create
  after_create :assign_inital_role
  after_validation :create_tenant_if_is_valid, only: [:create]

  rolify

  has_many :users_roles
  has_many :roles, through: :users_roles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  belongs_to :tenant
  validates_presence_of :tenant, unless: :new_record?
  validates_presence_of :subdomain, if: :new_record?
  validates_presence_of :role, if: :new_record?

  def assign_inital_role
    puts setted_role
    self.add_role(role || :user) if self.roles.blank?
  end

  def create_tenant_if_is_valid
    return unless errors.empty?
    if role == 'admin'
      self.tenant = Tenant.create! subdomain: self.subdomain
    else
      self.tenant = Tenant.find subdomain: self.subdomain
    end

  end

  alias_method :setted_role, :role
  def role
    %w(user provider admin).include?(setted_role) ? setted_role : nil
  end
end
