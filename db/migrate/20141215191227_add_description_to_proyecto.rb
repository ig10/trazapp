class AddDescriptionToProyecto < ActiveRecord::Migration
  def change
    add_column :proyectos, :descripcion, :text
  end
end
