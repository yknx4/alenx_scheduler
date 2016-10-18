class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    # enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table :schedules do |t|
      t.string :timezone, null: false, default: 'America/Mexico_City'
      t.string :holidays, array: true, default: []
      t.hstore :breaks, null: false, default: ''
      t.hstore :hours, null: false, default: nil

      t.timestamps
    end
  end
end
