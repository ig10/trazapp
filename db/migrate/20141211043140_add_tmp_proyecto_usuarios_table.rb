class AddTmpProyectoUsuariosTable < ActiveRecord::Migration
  def change
    create_table :tmp_proyectos_usuarios, id: false do |t|
      t.integer :tmp_proyecto_id
      t.integer :usuario_id
    end
    add_index :tmp_proyectos_usuarios, :tmp_proyecto_id
    add_index :tmp_proyectos_usuarios, :usuario_id
  end
end
