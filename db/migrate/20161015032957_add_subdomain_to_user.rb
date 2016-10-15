class AddSubdomainToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :subdomain, :string, null: false, default: ''
    add_index :users, :subdomain
  end
end
