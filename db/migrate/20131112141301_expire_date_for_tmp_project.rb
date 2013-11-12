class ExpireDateForTmpProject < ActiveRecord::Migration
  def change
    add_column :tmp_proyectos, :expire_date, :date
  end
end
