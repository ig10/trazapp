class ModifyFieldsForTareas < ActiveRecord::Migration
  def change
    add_column :tareas, :puntos, :integer, default: 0
    add_column :tareas, :nombre, :string
  end
end
