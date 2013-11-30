class Proyecto < ActiveRecord::Base
  has_many :alumnos, :class_name => 'Usuario', :foreign_key => 'proyecto_id'
  has_many :actividades, :class_name => 'Actividad', :foreign_key => 'proyecto_id'

  delegate :rut, :nombre_completo, :correo_electronico, to: :alumnos
  validates_presence_of :nombre
  attr_accessible :estado, :fecha_cierre, :nombre
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



end
