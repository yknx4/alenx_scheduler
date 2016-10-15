class Tenant < ApplicationRecord
  validates_presence_of :subdomain
  has_many :users
end
