class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :rut
      t.string :nombres
      t.string :apellido_paterno
      t.string :apellido_materno
      t.integer :carrera
      t.integer :sede
      t.date :fecha_inicio

      t.timestamps
    end
  end
end
