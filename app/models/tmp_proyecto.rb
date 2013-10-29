class TmpProyecto < ActiveRecord::Base
  has_many :alumnos, :class_name => 'Usuario', :foreign_key => 'proyecto_id'
  has_many :actividades, :class_name => 'TmpActividad', :foreign_key => 'proyecto_id'
  attr_accessible :estado, :nombre
  delegate :rut, :nombre_completo, :correo_electronico, to: :alumnos

  validates_presence_of :nombre
  before_save :formatear_nombre

  def formatear_nombre
    self.nombre = self.nombre.titleize
  end

  def codigo_acceso
    Digest::SHA1.hexdigest("RxO39kysE#{id}uoYx#{created_at.strftime('%H%S')}LwQ4r7Di9hOV")[2..10]
  end

end
