class SetDefaultValuesForTask < ActiveRecord::Migration
  def change
    change_column :tareas, :estado, :string, default: "incompleta"
    change_column :tareas, :evaluacion, :float, default: 0.0
  end
end
