class UsersRole < ApplicationRecord
  validates :user, :role, presence: true
  belongs_to :user
  belongs_to :role
end
