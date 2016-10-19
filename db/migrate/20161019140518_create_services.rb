class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.string :tag

      t.timestamps
    end
    add_index :services, :tag, unique: true
  end
end
