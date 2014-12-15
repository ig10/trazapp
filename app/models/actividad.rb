class Actividad < ActiveRecord::Base
  belongs_to :proyecto, class_name: 'Proyecto', foreign_key: 'proyecto_id'
  has_many :tareas, class_name: 'Tarea', foreign_key: 'actividad_id'
  attr_accessible :complejidad, :estado, :funcionalidad, :modulo, :progreso, :proyecto_id, :revision, :dia, :mes, :anio, :nombre, :puntos, :evaluacion
  attr_accessor :dia, :mes, :anio

  before_create :formatear_fecha
  before_save :set_revision

  Complejidad = {"Baja" => 1,"Media" => 2, "Alta" => 3}
  ESTADOS = [['Completa', 'completa'], ['Incompleta','incompleta']]


  def formatear_fecha
    unless dia.nil? and mes.nil? and anio.nil?
      self.revision = [dia,mes,anio].join("-").to_time
    else
      logger.error "\033[31m FORMATTING DATE ERROR! \033[0m"
    end
  end

  def progreso

    if self.tareas.any?
      total = rand(1..100) #self.tareas.count
      completas = rand(1..total) #self.tareas.total-completas
    else
      if self.evaluacion != 0
        total = 100
        completas = 100
      else
        total = rand(1..100) #self.tareas.count
        completas = rand(1..total) #self.tareas.total-completas
      end
    end

    {completo: (completas*100/total).round, incompleto: total-completas}
  end

  def set_revision
    self.revision = Time.now + 1.month
  end

end
