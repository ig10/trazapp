class Actividad < ActiveRecord::Base
  belongs_to :proyecto, class_name: 'Proyecto', foreign_key: 'proyecto_id'
  has_many :tareas, class_name: 'Tarea', foreign_key: 'actividad_id'
  attr_accessible :complejidad, :estado, :funcionalidad, :modulo, :progreso, :proyecto_id, :revision, :dia, :mes, :anio
  attr_accessor :dia, :mes, :anio

  before_create :formatear_fecha

  Complejidad = {"Baja" => 1,"Media" => 2, "Alta" => 3}

  def formatear_fecha
    unless dia.nil? and mes.nil? and anio.nil?
      self.revision = [dia,mes,anio].join("-").to_time
    else
      logger.error "\033[31m FORMATTING DATE ERROR! \033[0m"
    end
  end

  def progreso
    total = rand(1..100) #self.tareas.count
    completas = rand(1..total) #self.tareas.completas

    {completo: (completas*100/total).round, incompleto: total-completas}
  end

end
