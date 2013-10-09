class Usuario < ActiveRecord::Base
  has_one :proyecto, :class_name => 'TmpProyecto', :foreign_key => 'proyecto_id'
  attr_accessible :activo, :carrera, :correo_electronico, :nombre_completo, :perfil, :rut, :sede, :proyecto_id

  validates_presence_of :rut, :correo_electronico, :nombre_completo

end
