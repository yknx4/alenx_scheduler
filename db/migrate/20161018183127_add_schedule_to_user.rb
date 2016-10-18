class AddScheduleToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :schedule, foreign_key: true
  end
end
