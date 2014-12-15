class Proyecto < ActiveRecord::Base
  has_and_belongs_to_many :alumnos, class_name: 'Usuario', foreign_key: 'proyecto_id'
  has_many :actividades, class_name: 'Actividad'
  has_one :estructura, class_name: 'Estructura', foreign_key: 'id', primary_key: 'estructura_id'
  belongs_to :seccion

  delegate :rut, :nombre_completo, :correo_electronico, to: :alumnos
  validates_presence_of :nombre
  attr_accessible :estado, :fecha_cierre, :nombre, :estructura_id, :seccion_sigla, :descripcion
  before_save :establecer_cierre

  ESTADOS = {"Activo" => "activo", "Inactivo" => "inactivo", "Expirado" => "expirado", "Evaluado" => "evaluado"}

  def formatear_nombre
    self.nombre = self.nombre.titleize
  end

  def establecer_cierre
    self.fecha_cierre = 3.months.from_now
  end

  def codigo_acceso
    Digest::SHA1.hexdigest("TxOkysE#{id}uoYx#{created_at.strftime('%H%S')}MwpI7F8i9hOV")[3..11]
  end

  def progreso
    total = rand(1..100) #self.tareas.count
    completas = rand(1..total) #self.tareas.completas

    {completo: (completas*100/total).round, incompleto: total-completas}
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
