class RenameNotaColumnInActividades < ActiveRecord::Migration
  def change
    rename_column :actividades, :nota, :evaluacion
  end
end
