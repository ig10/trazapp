class TmpProyecto < ActiveRecord::Base
  has_many :alumnos, :class_name => 'Usuario', :foreign_key => 'proyecto_id'
  has_many :actividades, :class_name => 'TmpActividad', :foreign_key => 'proyecto_id'
  belongs_to :seccion, class_name: 'Seccion', foreign_key: 'seccion_id'
  attr_accessible :estado, :nombre, :descripcion
  delegate :rut, :nombre_completo, :correo_electronico, to: :alumnos

  validates_presence_of :nombre, :descripcion

  before_save :formatear_nombre, :expirar

  def formatear_nombre
    self.nombre = self.nombre.titleize
  end

  def codigo_acceso
    Digest::SHA1.hexdigest("RxO39kysE#{id}uoYx#{created_at.strftime('%H%S')}LwQ4r7Di9hOV")[2..10]
  end

  def cantidad_actividades
    self.actividades.count
  end

  def evaluacion
    #Must be deleted after Bug Fix on classes and model name
    rand(1.0..7.0).round(1)
  end

  def expirar
    fecha_expiracion = Time.now + 15.days
  end

end
