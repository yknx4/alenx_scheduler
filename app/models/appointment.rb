class Appointment < ApplicationRecord
  validates_presence_of :user, :provider, :start_time, :end_time
  validate :star_date_cannot_be_later_than_end_time
  
  belongs_to :provider, class_name: 'User'
  belongs_to :user

  private
  def star_date_cannot_be_later_than_end_time
    if start_time > end_time
      errors.add :start_time, "can't be later than end time"
    end
  end
end
