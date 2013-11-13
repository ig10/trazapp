class Tarea < ActiveRecord::Base
  belongs_to :actividad, class_name: 'Actividad', foreign_key: 'actividad_id'
  attr_accessible :actividad_id, :descripcion, :estado, :evaluacion, :revision
end
