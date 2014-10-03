class AddHstoreExtension < ActiveRecord::Migration
  def up
    # User assoc needs to be SuperUser in PG
    execute "CREATE EXTENSION IF NOT EXISTS hstore;"
  end

  def down
    # User assoc needs to be SuperUser in PG
    execute "DROP EXTENSION IF EXISTS hstore;"
  end
end
