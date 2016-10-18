class Schedule < ApplicationRecord
  prepend HasBizConcern
  validates_presence_of :timezone, :hours
  has_one :organization
end
