class AddStructureTable < ActiveRecord::Migration
  def change
    create_table :estructuras do |t|
      t.string :nombre
      t.hstore :json
      t.timestamp
    end
  end
end