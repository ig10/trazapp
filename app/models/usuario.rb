class Usuario < ActiveRecord::Base
  belongs_to :solicitud, class_name: 'TmpProyecto', foreign_key: 'proyecto_id'
  belongs_to :proyecto, :class_name => 'TmpProyecto', :foreign_key => 'proyecto_id'
  attr_accessible :activo, :carrera, :correo_electronico, :nombre_completo, :perfil, :rut, :sede, :proyecto_id

  validates_presence_of :rut, :correo_electronico, :nombre_completo

  scope :con_rut, lambda{ |rut| where(rut: rut) unless rut.blank? }
  scope :de_sede, lambda{ |sede| where(sede: sede) unless sede.blank? }
  scope :con_estado, lambda{ |estado| where(estado: estado) unless estado.blank? }
  scope :creado_el, lambda{ |fecha| where(fecha) unless fecha.blank? }
  scope :con_cierre_el, lambda{ |fecha| where(fecha) unless fecha.blank? }

  SEDES = ["Alameda", "Antonio Varas", "Concepción", "Maipú", "Melipilla", "Padre Alonso de Ovalle", "Plaza Norte", "Plaza Oeste", "Plaza Vespucio", "Puente Alto", "Renca", "San Bernardo", "San Carlos de Apoquindo", "San Joaquín", "Valparaiso", "Viña del Mar"]

  def self.rut_alumnos
    self.where(perfil: 'alumno').uniq.order(:rut).pluck(:rut)
  end

  def self.reporte_alumnos(params)
    alumnos = self.
               joins(:proyecto).
               con_rut(params["rut"]).
               de_sede(params["sede"]).
               con_estado(params["estado"]).
               creado_el(crear_fecha_busqueda('tmp_proyectos.created_at', params['inicio_dia'], params['inicio_mes'], params['inicio_anio'])).
               con_cierre_el(crear_fecha_busqueda('fecha_expiracion', params['cierre_dia'], params['cierre_mes'], params['cierre_anio']))

    if alumnos.any?
      package = Axlsx::Package.new
      book = package.workbook
      sheet = book.add_worksheet(name: "Reporte Alumnos")
      sheet.add_row(["Rut","Nombre Completo", "Correo Electrónico", "Sede", "Carrera", "¿Activo?", "Proyecto", "Nombre", "Estado", "Cantidad Actividades", "Evaluacion", "Fecha Cierre" ])
      alumnos.each do |alumno|
        sheet.add_row([
          alumno.rut,
          alumno.nombre_completo,
          alumno.correo_electronico,
          alumno.sede,
          alumno.carrera,
          alumno.activo ? "Si" : "No",
          ">>",
          alumno.proyecto.nombre,
          alumno.proyecto.estado,
          alumno.proyecto.cantidad_actividades,
          alumno.proyecto.evaluacion,
          alumno.proyecto.fecha_expiracion
        ])
      end

     return package

    end




  end

  private

  def self.crear_fecha_busqueda(tipo, dia, mes, anio)
    concat = false
    str = ""
    str += "date_part('day', #{tipo}) = '#{dia}'" if concat = dia.present?
    str += " AND " if concat
    str += "date_part('month', #{tipo}) = '#{mes}'" if concat = mes.present?
    str += " AND " if concat
    str += "date_part('year', #{tipo}) = '#{anio}'" if anio.present?
    str
  end

end
