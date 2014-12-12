class TmpProyectosController < ApplicationController

  def index
    @tmp_proyectos = TmpProyecto.order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tmp_proyectos }
    end
  end

  def show
    @tmp_proyecto = TmpProyecto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tmp_proyecto }
    end
  end

  def new
    @tmp_proyecto = TmpProyecto.new
    variables_comunes
  end

  def edit
    @tmp_proyecto = TmpProyecto.find(params[:id])
    if @tmp_proyecto
      variables_comunes
      @estructuras = Estructura.for_select
      @seccion = @tmp_proyecto.seccion
      @alumnos_solicitud = @tmp_proyecto.alumnos
      @alumnos_seccion = (@seccion.usuarios - @alumnos_solicitud).map{|a| [a.nombre_completo, a.id]}
      render :edit
    else
      flash[:error] = "Proyecto no encontrado"
      redirect_to solicitudes_url
    end
  end

  def create
    @solicitud = TmpProyecto.create(params[:tmp_proyecto])
    guardar_solicitud
  end

  def update
    @solicitud = TmpProyecto.find(params[:id])
    @solicitud.update_attributes(params[:tmp_proyecto])
    guardar_solicitud
  end

  def destroy
    @tmp_proyecto = TmpProyecto.find(params[:id])
    @tmp_proyecto.destroy

    respond_to do |format|
      format.html { redirect_to '/solicitudes' }
      format.json { head :no_content }
    end
  end

  def aprobar
    if request.post?
      proyecto = Proyecto.create(params[:tmp_proyecto])
      if proyecto.errors.empty?
        actividades = Estructura.find(params[:id]).json
        actividades.each do |key|
          if actividades[key].is_a?(String)
            Actividad.create(
              proyecto_id: proyecto.id,
              nombre: key,
              puntos: actividades[key].to_i,
              progreso: 0
              )
          else
            actividad = Actividad.create(
              proyecto_id: proyecto.id,
              nombre: key,
              puntos: 0,
              progreso: 0
              )
            actividades[key].keys.each do |tarea_key|
              Tarea.create(
                actividad_id: actividad.id,
                nombre: tarea_key,
                puntos: actividades[key][tarea_key]
                )
            end
          end
        end
        flash[:notice] = "Proyecto #{proyecto.nombre} activado exitosamente"
        redirect_to proyectos_url
      else
        flash[:error] = "Error al aprobar/crear nuevo Proyecto"
        redirect_to solicitudes_url
      end
    else
      redirect_to editar_solicitud_url(params[:id])
    end
  end

  private

    def variables_comunes
      @alumnos = Seccion.to_hash.to_json
      @secciones = JSON.parse(@alumnos).keys
      @alumnos_seccion = []
      @alumnos_solicitud = []
    end

    def guardar_solicitud
      lista = params[:lista_alumnos].split(',')
      if @solicitud.errors.empty?
        @solicitud.alumnos = Usuario.where(id: lista)
        redirect_to(action: 'show', id: @solicitud.id)
      else
        flash[:error] = "Los datos fueron ingresados Incorrectamente"
        redirect_to(action: 'new')
      end
    end

end
