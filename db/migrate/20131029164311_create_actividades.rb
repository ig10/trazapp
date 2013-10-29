class CreateActividades < ActiveRecord::Migration
  def change
    create_table :actividades do |t|
      t.integer :proyecto_id
      t.string :modulo
      t.string :funcionalidad
      t.integer :complejidad
      t.string :estado
      t.date :revision
      t.float :progreso

      t.timestamps
    end
  end
end
