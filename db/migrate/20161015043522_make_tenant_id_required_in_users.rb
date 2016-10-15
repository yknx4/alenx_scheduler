class MakeTenantIdRequiredInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column_null(:users, :tenant_id, false)
  end
end
