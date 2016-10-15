class CreateTenants < ActiveRecord::Migration[5.0]
  def change
    create_table :tenants do |t|
      t.string :subdomain, null: false, default: '', unique: true

      t.timestamps
    end
  end
end
