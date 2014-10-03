class AddStructureRelationToProjects < ActiveRecord::Migration
  def change
    add_column :proyectos, :estructura_id, :integer
  end
end
