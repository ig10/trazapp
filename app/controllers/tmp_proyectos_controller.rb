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
    @complejidad = TmpActividad::Complejidad
    render :new, layout: 'alumno'
  end

  def edit
    @tmp_proyecto = TmpProyecto.find(params[:id])
  end

  def create
    proyecto = TmpProyecto.create({nombre: params[:tmp_proyecto][:nombre]})

    if proyecto.id.present?
      users = 1
      until params["alumno_#{users}"].nil?
        alumno = params["alumno_#{users}"].merge({proyecto_id: proyecto.id, perfil: 'alumno'})
        users = (Usuario.create(alumno) ? users + 1 : 0)
      end
    else
      flash[:notice] = "ERROR!, No se pudo crear proyecto"
      redirect_to action: 'new'
    end
  end

  def update
    @tmp_proyecto = TmpProyecto.find(params[:id])

    respond_to do |format|
      if @tmp_proyecto.update_attributes(params[:tmp_proyecto])
        format.html { redirect_to @tmp_proyecto, notice: 'Tmp proyecto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tmp_proyecto.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tmp_proyecto = TmpProyecto.find(params[:id])
    @tmp_proyecto.destroy

    respond_to do |format|
      format.html { redirect_to tmp_proyectos_url }
      format.json { head :no_content }
    end
  end
end
