class Schedule < ApplicationRecord
  validates_presence_of :timezone, :hours, :schedulable
  belongs_to :schedulable, polymorphic: true
end
