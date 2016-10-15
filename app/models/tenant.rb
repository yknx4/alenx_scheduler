class Tenant < ApplicationRecord
  has_many :users
end
