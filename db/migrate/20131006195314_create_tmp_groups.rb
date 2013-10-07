class CreateTmpGroups < ActiveRecord::Migration
  def change
    create_table :tmp_groups do |t|
      t.string :nombre_proyecto
      t.text :users_hash
      t.text :activities_hash
      t.string :estado

      t.timestamps
    end
  end
end
