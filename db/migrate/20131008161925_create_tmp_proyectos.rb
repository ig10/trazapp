class CreateTmpProyectos < ActiveRecord::Migration
  def change
    create_table :tmp_proyectos do |t|
      t.string :nombre
      t.string :estado

      t.timestamps
    end
  end
end
