class TmpActividad < ActiveRecord::Base
  belongs_to :proyecto, :class_name => 'TmpProyecto', :foreign_key => 'proyecto_id', dependent: :destroy
  attr_accessible :complejidad, :estado, :funcionalidad, :modulo, :proyecto_id, :revision, :dia, :mes, :anio
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


end
