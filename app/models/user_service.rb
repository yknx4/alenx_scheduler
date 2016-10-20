class UserService < ApplicationRecord
  validates :user, :service, presence: true
  validates :service, uniqueness: { scope: :user }
  belongs_to :user
  belongs_to :service
end
