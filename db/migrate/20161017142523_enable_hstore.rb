class EnableHstore < ActiveRecord::Migration[5.0]
  def up
    execute 'CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA pg_catalog;'
  end

  def down
    execute 'DROP EXTENSION IF EXISTS hstore WITH SCHEMA pg_catalog;'
  end
end
