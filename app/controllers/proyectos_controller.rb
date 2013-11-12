class ProyectosController < ApplicationController
  layout 'application'
  def index
    @proyectos = Proyecto.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @proyectos }
    end
  end

  def show
    @proyecto = Proyecto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @proyecto }
    end
  end

  def new
    @proyecto = Proyecto.new
    @actividad = Actividad.new
    @complejidad = Actividad::Complejidad
  end

  def edit
    @proyecto = Proyecto.find(params[:id])
    if @proyecto and @proyecto.codigo_acceso.eql?(params[:codigo_acceso])
      @actividades = @proyecto.actividades
      @alumnos = @proyecto.alumnos
      @complejidad = Actividad::Complejidad
    else
      flash[:error] = "Proyecto no encontrado"
      redirect_to '/activos'
    end
  end

  def create
    proyecto = Proyecto.create({nombre: params[:proyecto][:nombre]})

    if proyecto.id.present?
      users = 1
      until params["alumno_#{users}"].nil?
        alumno = params["alumno_#{users}"].merge({proyecto_id: proyecto.id, perfil: 'alumno'})
        users = (Usuario.create(alumno) ? users + 1 : 0)
      end

      actividades = 1
      until params["actividad_#{actividades}"].nil?
        actividad = params["actividad_#{actividades}"].merge({proyecto_id: proyecto.id})
        actividades = (Actividad.create(actividad) ? actividades + 1 : 0)
      end

      render text: 'OK' #devolver codigo de acceso
    else
      flash[:notice] = "ERROR!, No se pudo crear proyecto"
      redirect_to action: 'new'
    end
  end

  def update
    render text: "UPDATE!\n#{params.inspect}"
  end

  def destroy
    @proyecto = Proyecto.find(params[:id])
    @proyecto.destroy

    respond_to do |format|
      format.html { redirect_to proyectos_url }
      format.json { head :no_content }
    end
  end
end
