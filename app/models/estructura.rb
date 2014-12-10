class Estructura < ActiveRecord::Base
  has_many :proyectos, class_name: 'Proyecto', foreign_key: 'estructura_id'
  serialize :json, ActiveRecord::Coders::NestedHstore
  attr_accessible :nombre, :json

  validates_uniqueness_of :nombre

  def to_h(themes, points)
    division = points.map{ |x| x.split('-') }
    categories = division.map{ |x| [x.first.strip.split('.').compact, x.second.strip] }
    categorized = categories.group_by{ |e| e.first.first  }
  end

  def self.load(name, file)
    # LOGIC IN PROGRESS, MEANWHILE HARD CODED LOAD
    begin
      json = format_file(file)
      self.create({
        nombre: name,
        json: self.send(name.gsub(' ', '_').underscore)
        })
      return true
    rescue Exception => e
      logger.info "*** ERROR: " + e.to_s
      return false
    end
  end

  def self.format_file(file); end



    def self.taller_de_sistemas
      JSON.parse('{
        "Introducción": "20",
        "Objetivos Generales" : "20",
        "Objectivos Específicos": "20",
        "Definición del Proyecto": "20",
        "Antecedentes de la Empresa": {
          "Estructura Organizacional": "20",
          "Personal": "20",
          "Objetivos de la empresa": "20",
          "FODA de la Empresa": "20",
          "Posición de la empresa en el mercado": "20",
          "5 Fuerzas de Porter": "20",
          "Descripción del proceso productivo o servicio": "20",
          "Modelo de Proceso de Negocios BPM": "20",
          "Ambiente informático actual": "20"
        },
        "Análisis del Proyecto": {
          "Antecedentes": "20",
          "Características generales de la solución requerida": "20",
          "Metodología aplicada para la toma de requerimiento": "20",
          "Definición de Requerimientos funcionales del cliente": "20",
          "Definicion de Requerimientos no funcionales": "20",
          "Minutas de Reunion": "20",
          "Funcionalidades del Protecto": "20",
          "Restricciones del Proyecto": "20",
          "Identificación de Riesgos": "20",
          "Análisis de Riesgos Críticos": "20",
          "Plan de Contigencia": "20"
        },
        "Estudio de Factibilidad": {
          "FODA del Proyecto": "20",
          "Factibilidad Operacional": "20",
          "Factibilidad Legal": "20",
          "Factibilidad Técnica": "20",
          "Factibilidad Econónomica (VAN o VAC)": "20"
        },
        "Métricas de Estimación": {
          "Modelo COCOMO": "20",
          "Modelo PUTNAM": "20",
          "Comparación y discusión de valores obtenidos": "20"
        },
        "Planificación del Proyecto": {
          "Carta Gantt": "20",
          "Diagrama de Red o PERT - CPM": "20"
        },
        "Diseño del Proyecto": {
          "Elección y fundamentación del Modelo de Desarrollo de Software": "20",
          "Diseño lógico BD": "20",
          "Diseño Físico": "20",
          "Descripción de Caso de Uso": "20",
          "Diagrama de casos de uso": "20",
          "Diagrama de actividades": "20",
          "Diagrama de secuencia": "20",
          "Diagrama de Clases": "20",
          "Plan de Puesta en Marcha Blanca del Sistema": "20",
          "Poblamiento de Datos": "20"
        },
        "Prototipo": "20",
        "Testing del Software": {
          "Plan de Pruebas y Escenarios de Prueba": "20",
          "Definición de Casos de Prueba": "20"
        },
        "Conclusiones": "20",
        "Bibliografía": "20"
      }')

    end


end