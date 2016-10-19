class Service < ApplicationRecord
  validates_presence_of :tag
  validates_uniqueness_of :tag
  has_many :user_services
  has_many :users, through: :user_services
end
