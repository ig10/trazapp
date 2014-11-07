class AddColumnDescriptionInTmpProyectos < ActiveRecord::Migration
  def change
    add_column :tmp_proyectos, :descripcion, :text
  end
end
