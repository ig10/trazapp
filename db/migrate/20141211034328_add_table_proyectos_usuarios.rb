class AddTableProyectosUsuarios < ActiveRecord::Migration
  def change
    create_table :proyectos_usuarios, id: false do |t|
      t.integer :proyecto_id
      t.integer :usuario_id
    end
    add_index :proyectos_usuarios, :proyecto_id
    add_index :proyectos_usuarios, :usuario_id
  end
end
