class Schedule < ApplicationRecord
  prepend HasBizConcern
  validates :timezone, :hours, presence: true
  has_one :organization
  has_one :user

  after_initialize :set_default_values

  private

  def set_default_values
    self.hours ||= {
      mon: { '09:00' => '15:00' },
      tue: { '09:00' => '15:00' },
      wed: { '09:00' => '15:00' },
      thu: { '09:00' => '15:00' },
      fri: { '09:00' => '15:00' }
    }
  end
end
