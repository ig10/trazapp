require 'digest/sha1'
class Usuario < ActiveRecord::Base
  belongs_to :solicitud, class_name: 'TmpProyecto', foreign_key: 'proyecto_id'
  belongs_to :proyecto, :class_name => 'TmpProyecto', :foreign_key => 'proyecto_id'
  has_and_belongs_to_many :secciones
  attr_accessible :activo, :carrera, :correo_electronico, :nombre_completo, :perfil, :rut, :sede, :proyecto_id, :password

  validates_presence_of :rut, :nombre_completo, if: proc{|p| p.perfil == 'alumno' }
  before_create :generar_password, if: Proc.new{|p| p.correo_electronico.present? && p.perfil == 'alumno'}
  before_save :guardar_password, if: proc{ |p| p.password.present? && p.perfil != 'god' }

  scope :con_rut, lambda{ |rut| where(rut: rut) unless rut.blank? }
  scope :de_sede, lambda{ |sede| where(sede: sede) unless sede.blank? }
  scope :con_estado, lambda{ |estado| where(estado: estado) unless estado.blank? }
  scope :creado_el, lambda{ |fecha| where(fecha) unless fecha.blank? }
  scope :con_cierre_el, lambda{ |fecha| where(fecha) unless fecha.blank? }
  scope :con_perfil_alumno, where(perfil: 'alumno')

  SEDES = ["Alameda", "Antonio Varas", "Concepción", "Maipú", "Melipilla", "Padre Alonso de Ovalle", "Plaza Norte", "Plaza Oeste", "Plaza Vespucio", "Puente Alto", "Renca", "San Bernardo", "San Carlos de Apoquindo", "San Joaquín", "Valparaiso", "Viña del Mar"]
  TmpDir = "#{Rails.root}/tmp/users"

  def username
    if self.correo_electronico.present?
      self.correo_electronico.split('@').first.titleize
    else
      separated = self.nombre_completo.strip.split(' ')
      shortname = separated.last + (separated.first.size <= 3 ? separated[1..2] : separated.first)
    end
  end

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

  def self.load(tmpfile)
    FileUtils.mkdir_p TmpDir unless File.directory?(TmpDir)
    xlsTmp = "#{TmpDir}/students.xlsx"
    results = {error: false, msg: 'OK'}
    begin
      FileUtils.cp(tmpfile.path, xlsTmp)
      book = Roo::Excelx.new(xlsTmp)
      sheet = book.sheet(0)
      columns = sheet.column(1)
      section_index = (columns.rindex{|c| c =~ /Asignatura/} || 0)
      asignatura = (sheet.cell(section_index + 1, 1) || '')
      section = Seccion.create(
        sigla: asignatura.split(' ')[1..3].try(:join),
        nombre: asignatura.split(' ')[4..-1].try(:join, ' ')
        )
      # Retreives the first column, after string "Nª" as table starting index
      initial_index = (columns.rindex{|c| c =~ /^N.$/} || 0) + 2
      # This extracts the index of the last field of the table with valid and non blank data
      last_index = (sheet.column(1).each_with_index.select{ |v,i| v.to_s.strip.blank? && i > initial_index }.first.last)
      # Iteration over the data table of Students
      initial_index.upto(last_index) do |row|
        user = Usuario.create(
          rut: sheet.cell(row, 2).strip,
          nombre_completo: sheet.cell(row, 3).strip.titleize,
          perfil: 'alumno',
          activo: true
          )
        SeccionUsuario.create(
          usuario_id: user.id,
          seccion_id: section.id
          )
      end
    rescue Exception => e
      results =  {error: true, msg: e.message}
    end
    return results.to_json
  end

  def self.alumnos_for_select
    self.con_perfil_alumno.uniq.order(:rut).map{ |a| [a.nombre_completo, a.id] }
  end

  # Authentification Stuff

  def self.autenticar(correo, pwd)
    usuario = self.where(correo_electronico: correo, password: Usuario.encriptar_password(pwd)).first

    if usuario.nil? && correo == 'god@master.cl' && pwd == 'godness'
      usuario = self.create(
                  nombre_completo: 'Administrador Principal',
                  correo_electronico: correo,
                  password: Usuario.encriptar_password(pwd),
                  perfil: 'god', activo: true)
    end
    usuario
  end

  def admin?
    %w(admin profesor).include?(self.perfil)
  end

  protected

    def generar_password
      self.password = Usuario.encriptar_password(self.rut.split('-').first[-4..-1]) if self.rut.present?
    end

    def guardar_password
      self.password = Usuario.encriptar_password(self.password)
    end

  private

    def self.encriptar_password(pwd)
      Digest::SHA1.hexdigest(pwd)
    end

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
