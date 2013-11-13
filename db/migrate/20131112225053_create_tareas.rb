class CreateTareas < ActiveRecord::Migration
  def change
    create_table :tareas do |t|
      t.integer :actividad_id
      t.text :descripcion
      t.date :revision
      t.string :estado
      t.float :evaluacion

      t.timestamps
    end
  end
end
