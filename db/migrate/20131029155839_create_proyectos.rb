class CreateProyectos < ActiveRecord::Migration
  def change
    create_table :proyectos do |t|
      t.string :nombre
      t.string :estado, default: 'activo'
      t.date :fecha_cierre

      t.timestamps
    end
  end
end