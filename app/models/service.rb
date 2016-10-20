class Service < ApplicationRecord
  validates :tag, presence: true
  validates :tag, uniqueness: true
  has_many :user_services
  has_many :users, through: :user_services
end
