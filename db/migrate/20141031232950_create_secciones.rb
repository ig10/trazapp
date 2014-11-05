class CreateSecciones < ActiveRecord::Migration
  def change
    create_table :secciones do |t|
      t.string :id
      t.string :nombre
      t.string :jornada

      t.timestamps
    end
  end
end
