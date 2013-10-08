class TmpGroupsController < ApplicationController
  # GET /tmp_groups
  # GET /tmp_groups.json
  def index
    @tmp_groups = TmpGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tmp_groups }
    end
  end

  # GET /tmp_groups/1
  # GET /tmp_groups/1.json
  def show
    @tmp_group = TmpGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tmp_group }
    end
  end

  # GET /tmp_groups/new
  # GET /tmp_groups/new.json
  def new
    @tmp_group = TmpGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tmp_group }
    end
  end

  # GET /tmp_groups/1/edit
  def edit
    @tmp_group = TmpGroup.find(params[:id])
  end

  # POST /tmp_groups
  # POST /tmp_groups.json
  def create
    @tmp_group = TmpGroup.new(params[:tmp_group])

    respond_to do |format|
      if @tmp_group.save
        format.html { redirect_to @tmp_group, notice: 'Tmp group was successfully created.' }
        format.json { render json: @tmp_group, status: :created, location: @tmp_group }
      else
        format.html { render action: "new" }
        format.json { render json: @tmp_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tmp_groups/1
  # PUT /tmp_groups/1.json
  def update
    @tmp_group = TmpGroup.find(params[:id])

    respond_to do |format|
      if @tmp_group.update_attributes(params[:tmp_group])
        format.html { redirect_to @tmp_group, notice: 'Tmp group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tmp_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tmp_groups/1
  # DELETE /tmp_groups/1.json
  def destroy
    @tmp_group = TmpGroup.find(params[:id])
    @tmp_group.destroy

    respond_to do |format|
      format.html { redirect_to tmp_groups_url }
      format.json { head :no_content }
    end
  end

  def partial_alumno
    @rut = "tmp_group[rut_usuario_#{param[:rut]}]"
    @nombre = "tmp_group[nombre_usuario_#{param[:nombre]}]"
    @correo = "tmp_group[correo_usuario_#{param[:correo]}]"
    render partial: 'alumno'
  end
end
