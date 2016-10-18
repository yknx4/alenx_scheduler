class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.references :schedule, foreign_key: true

      t.timestamps
    end
    add_reference :organizations, :tenant, foreign_key: false
  end
end
