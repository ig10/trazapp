class AddJsonTypeColumnInEstructuras < ActiveRecord::Migration
  def up
    Estructura.destroy_all
    add_column :estructuras, :data, :text
  end

  def down
    Estructura.destroy_all
    remove_column :estructuras, :data
  end
end
