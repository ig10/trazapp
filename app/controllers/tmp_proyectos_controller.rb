class TmpProyectosController < ApplicationController
  def index
    @tmp_proyectos = TmpProyecto.all

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
    @tmp_actividad = TmpActividad.new
    @alumnos = Seccion.to_hash.to_json
    @secciones = JSON.parse(@alumnos).keys
    render :new, layout: 'alumno'
  end

  def edit
    @tmp_proyecto = TmpProyecto.find(params[:id])
    if @tmp_proyecto and @tmp_proyecto.codigo_acceso.eql?(params[:codigo_acceso])
      @actividades = @tmp_proyecto.actividades
      @alumnos = @tmp_proyecto.alumnos
      @complejidad = TmpActividad::Complejidad
      render :edit, layout: 'alumno' #validar session para layout
    else
      flash[:error] = "Proyecto no encontrado"
      redirect_to '/solicitudes'
    end
  end

  def create
    proyecto = TmpProyecto.create(params[:tmp_proyecto])
    lista = params[:lista_alumnos].split(',')
    if proyecto.errors.empty?
      alumnos = Usuario.where(id: lista).update_all(proyecto_id: proyecto.id)
      redirect_to(action: 'show', id: proyecto.id)
    else
      redirect_to(action: 'new')
    end
  end

  def update
    render text: "UPDATE!\n#{params.inspect}"
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
    #Funcion pasarla a worker cuando se implemente
    tmpProyecto = TmpProyecto.find(params[:id])
    if tmpProyecto.codigo_acceso.eql?(params[:codigo_acceso])
      proyecto = Proyecto.find_or_create_by_nombre(tmpProyecto.nombre)

      tmpProyecto.alumnos.each do |alumno|
        alumno.update_attributes({proyecto_id: proyecto.id, activo: true})
      end

      actividades = 0
      if proyecto.alumnos.any? and proyecto.actividades.empty?
        tmpProyecto.actividades.each do |tmp_act|
          act = Actividad.new
          act.proyecto = proyecto
          act.modulo = tmp_act.modulo
          act.funcionalidad = tmp_act.funcionalidad
          act.complejidad = tmp_act.complejidad
          act.estado = 'incompleta'
          act.revision = tmp_act.revision
          act.progreso = 0.0
          actividades += 1 if act.save
        end
        tmpProyecto.update_attribute(:estado,'aprobado') if actividades > 0
      end
      render text: tmpProyecto.estado.eql?('aprobado') ? "OK" : "ERROR"
    else
      render text: "ERROR AL ENCONTRAR PROYECTO"
    end
  end

end
