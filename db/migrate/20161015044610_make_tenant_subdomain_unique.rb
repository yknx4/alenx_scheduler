class MakeTenantSubdomainUnique < ActiveRecord::Migration[5.0]
  def change
    add_index :tenants, :subdomain, unique: true
  end
end
