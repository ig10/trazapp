class TmpProyecto < ActiveRecord::Base
  belongs_to :seccion
  has_and_belongs_to_many :alumnos, class_name: 'Usuario', foreign_key: 'tmp_proyecto_id'

  attr_accessible :estado, :nombre, :descripcion, :seccion_id, :seccion_sigla, :estructura
  delegate :rut, :nombre_completo, :correo_electronico, to: :alumnos

  attr_accessor :estructura

  validates_presence_of :nombre, :descripcion, :seccion

  before_create :expirar
  before_save :formatear_nombre

  ESTADOS = %w(aprobado pendiente rechazado)

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
    self.fecha_expiracion = Time.now + 15.days
  end

  def asignar_seccion
    unless self.seccion_sigla.nil?
      self.seccion = Seccion.where(sigla: seccion_sigla).first
    end
  end

  def seccion_sigla
    if self.seccion.present?
      self.seccion.sigla
    else
      @seccion_sigla
    end
  end

  def seccion_sigla=(sigla)
    unless sigla.nil?
      self.seccion = Seccion.where(sigla: sigla).first
      @seccion_sigla = sigla
    end
  end

end
