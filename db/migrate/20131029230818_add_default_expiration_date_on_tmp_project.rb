class AddDefaultExpirationDateOnTmpProject < ActiveRecord::Migration
  def up
    TmpProyecto.all.each do |p|
      p.update_attribute(:fecha_expiracion, p.created_at + 1.month)
    end
  end

  def down
    TmpProyecto.all.each do |p|
      p.update_attribute(:fecha_expiracion, nil)
    end
  end
end