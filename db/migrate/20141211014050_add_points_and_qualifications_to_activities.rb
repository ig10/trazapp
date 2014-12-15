class AddPointsAndQualificationsToActivities < ActiveRecord::Migration
  def change
    add_column :actividades, :puntos, :integer, default: 0
    add_column :actividades, :nota, :float, default: 0.0
    rename_column :actividades, :modulo, :nombre
    remove_column :actividades, :funcionalidad
    remove_column :actividades, :complejidad
  end
end
