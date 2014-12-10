class ConfiguracionesController < ApplicationController
  layout 'application'

  def index
    @secciones = Seccion.for_select
    @historial = Configuracion.order('created_at DESC')
  end

  def load_students
    file = params[:load_excel]
    autor = current_user.id
    if Usuario.load(file.tempfile)
      load_status = 0
      flash[:notice] = "Usuarios cargados exitosamente"
    else
      load_status = 1
      flash[:error] = "Listado de usuarios inválido"
    end
    Configuracion.cargar(file, autor, load_status)
    redirect_to action: 'index'
  end

  def load_structure
    file = params[:structure_file]
    autor = current_user.id
    if Estructura.load(params[:nombre], file.tempfile)
      load_status = 0
      flash[:notice] = "Estructura Cargada exitosamente"
    else
      load_status = 1
      flash[:error] = "Estructura inválida"
    end
    Configuracion.cargar(file, autor, load_status)
    redirect_to action: 'index'
  end

end