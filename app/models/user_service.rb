class UserService < ApplicationRecord
  validates_presence_of :user, :service
  validates :service, uniqueness: { scope: :user }
  belongs_to :user
  belongs_to :service
end
