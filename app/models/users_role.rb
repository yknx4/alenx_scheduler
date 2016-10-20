class UsersRole < ApplicationRecord
  validates_presence_of :user, :role
  belongs_to :user
  belongs_to :role
end
