class AddSeccionColumnToProyectos < ActiveRecord::Migration
  def change
    add_column :tmp_proyectos, :seccion_id, :integer
    add_column :proyectos, :seccion_id, :integer
  end
end
