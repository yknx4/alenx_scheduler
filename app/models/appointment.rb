class Appointment < ApplicationRecord
  validates_presence_of :user, :provider, :start_time, :end_time
  belongs_to :provider, class_name: 'User'
  belongs_to :user
end
