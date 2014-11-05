class AddSeccionesAndUsuariosRelationTable < ActiveRecord::Migration
  def change
    create_table :secciones_usuarios, id: false do |t|
      t.integer :seccion_id
      t.integer :usuario_id
    end
    add_index :secciones_usuarios, :seccion_id
    add_index :secciones_usuarios, :usuario_id
  end
end
