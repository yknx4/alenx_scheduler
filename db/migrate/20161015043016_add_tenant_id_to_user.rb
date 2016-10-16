class AddTenantIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :tenant, foreign_key: false
    remove_column :users, :subdomain
  end
end
