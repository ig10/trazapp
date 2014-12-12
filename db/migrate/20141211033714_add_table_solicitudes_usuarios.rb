class AddTableSolicitudesUsuarios < ActiveRecord::Migration
  def change
    create_table :solicitudes_usuarios, id: false do |t|
      t.integer :solicitud_id
      t.integer :usuario_id
    end
    add_index :solicitudes_usuarios, :solicitud_id
    add_index :solicitudes_usuarios, :usuario_id
  end
end
