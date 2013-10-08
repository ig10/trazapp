class TmpProyecto < ActiveRecord::Base
  has_many :alumnos, :class_name => 'Usuario', :foreign_key => 'proyecto_id'
  has_many :actividades, :class_name => 'TmpActividad', :foreign_key => 'proyecto_id'
  attr_accessible :estado, :nombre
  delegate :rut, :nombre_completo, :correo_electronico, to: :alumnos

  validates_presence_of :nombre

end
