class ReportesController < ApplicationController
  def index
    @sedes = Usuario::SEDES
    @estados = Proyecto::ESTADOS
    @ruts = Usuario.rut_alumnos
  end

  def reporte_general
    package = Usuario.reporte_alumnos(params)
    begin
      file = Tempfile.new("Reporte Alumnos.xlsx")
      package.serialize file.path
      send_file file.path, filename: "Reporte Alumnos #{Time.now.strftime('%d/%m/%Y - %H:%M:%S')}.xlsx", type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    ensure
      file.close
    end
  end

end