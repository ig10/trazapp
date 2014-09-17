class AddFieldExpirationDateTmpProject < ActiveRecord::Migration
  def change
    add_column :tmp_proyectos, :fecha_expiracion, :date
  end
end
