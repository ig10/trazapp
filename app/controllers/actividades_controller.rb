class ActividadesController < ApplicationController

  def index
    @actividad = Actividad.find(params[:actividad])
    @tareas = @actividad.tareas
    @complejidad = Actividad::Complejidad
  end

  def edit
    @actividad = Actividad.find(params[:id])
    @tareas = @actividad.tareas
    @complejidad = Actividad::Complejidad
    render 'index'
  end

  def destroy
    @actividad = Actividad.find(params[:actividad])
    # @actividad.destroy

    respond_to do |format|
      format.html { redirect_to "/proyecto/editar/#{params[:id]}/#{params[:codigo_acceso]}" }
      format.json { head :no_content }
    end
  end

  def nueva_tarea
    @tarea = Tarea.new(actividad_id: params[:actividad])
    if request.put?
      @tarea.descripcion = params[:tarea][:descripcion]
      if @tarea.save
        @tareas = Tarea.where(actividad_id: params[:actividad])
        render partial: 'tareas'
      else
        render status: 500
      end
    else
      render partial: 'nueva_tarea'
    end
  end

end