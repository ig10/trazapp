class ConfiguracionesController < ApplicationController
  layout 'application'

  def index

  end

  def load_students
    file = params[:load_excel]
    Configuracion.cargar(file)
    render json: Usuario.load_students(file.tempfile)
  end


end