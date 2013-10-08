class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :rut
      t.string :nombre_completo
      t.string :correo_electronico
      t.integer :proyecto_id
      t.string :perfil
      t.string :sede
      t.string :carrera
      t.boolean :activo

      t.timestamps
    end
  end
end
