class AddConfigurationsTable < ActiveRecord::Migration

  def change
    create_table :configuraciones do |t|
      t.integer :autor
      t.string :nombre_archivo
      t.string :formato
      t.timestamps
    end
  end

end
