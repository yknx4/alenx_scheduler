class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :provider, references: :users
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_foreign_key :appointments, :users, column: :provider_id
  end
end
