class TmpActividadesController < ApplicationController
  # GET /tmp_actividades
  # GET /tmp_actividades.json
  def index
    @tmp_actividades = TmpActividad.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tmp_actividades }
    end
  end

  # GET /tmp_actividades/1
  # GET /tmp_actividades/1.json
  def show
    @tmp_actividad = TmpActividad.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tmp_actividad }
    end
  end

  # GET /tmp_actividades/new
  # GET /tmp_actividades/new.json
  def new
    @tmp_actividad = TmpActividad.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tmp_actividad }
    end
  end

  # GET /tmp_actividades/1/edit
  def edit
    @tmp_actividad = TmpActividad.find(params[:id])
  end

  # POST /tmp_actividades
  # POST /tmp_actividades.json
  def create
    @tmp_actividad = TmpActividad.new(params[:tmp_actividad])

    respond_to do |format|
      if @tmp_actividad.save
        format.html { redirect_to @tmp_actividad, notice: 'Tmp actividad was successfully created.' }
        format.json { render json: @tmp_actividad, status: :created, location: @tmp_actividad }
      else
        format.html { render action: "new" }
        format.json { render json: @tmp_actividad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tmp_actividades/1
  # PUT /tmp_actividades/1.json
  def update
    @tmp_actividad = TmpActividad.find(params[:id])

    respond_to do |format|
      if @tmp_actividad.update_attributes(params[:tmp_actividad])
        format.html { redirect_to @tmp_actividad, notice: 'Tmp actividad was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tmp_actividad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tmp_actividades/1
  # DELETE /tmp_actividades/1.json
  def destroy
    @tmp_actividad = TmpActividad.find(params[:id])
    @tmp_actividad.destroy

    respond_to do |format|
      format.html { redirect_to tmp_actividades_url }
      format.json { head :no_content }
    end
  end
end
