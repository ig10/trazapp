class SetExpireDateOnTmpProjects < ActiveRecord::Migration
  def up
    TmpProyecto.all.each do |p|
      p.update_attribute(:expire_date, p.created_at+1.month)
    end
  end

  def down
    TmpProyecto.update_all(expire_date: nil)
  end
end
