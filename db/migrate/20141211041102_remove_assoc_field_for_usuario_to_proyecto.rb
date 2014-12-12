class RemoveAssocFieldForUsuarioToProyecto < ActiveRecord::Migration
  def change
    remove_column :usuarios, :proyecto_id
  end
end
