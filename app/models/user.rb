class User < ApplicationRecord
  attr_accessor :role

  default_scope { distinct }

  scope :users, -> { with_role :user}
  scope :admins, -> { with_role :admin}
  scope :providers, -> { with_role :provider}

  # After Create
  after_create :assign_inital_role

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  belongs_to :tenant

  def assign_inital_role
    self.add_role(role || :user) if self.roles.blank?
  end

  def role
    [:user, :provider, :admin].include?(@role) ? @role : nil
  end
end
