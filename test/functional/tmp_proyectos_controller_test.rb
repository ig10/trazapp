require 'test_helper'

class TmpProyectosControllerTest < ActionController::TestCase
  setup do
    @tmp_proyecto = tmp_proyectos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tmp_proyectos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tmp_proyecto" do
    assert_difference('TmpProyecto.count') do
      post :create, tmp_proyecto: { estado: @tmp_proyecto.estado, nombre: @tmp_proyecto.nombre }
    end

    assert_redirected_to tmp_proyecto_path(assigns(:tmp_proyecto))
  end

  test "should show tmp_proyecto" do
    get :show, id: @tmp_proyecto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tmp_proyecto
    assert_response :success
  end

  test "should update tmp_proyecto" do
    put :update, id: @tmp_proyecto, tmp_proyecto: { estado: @tmp_proyecto.estado, nombre: @tmp_proyecto.nombre }
    assert_redirected_to tmp_proyecto_path(assigns(:tmp_proyecto))
  end

  test "should destroy tmp_proyecto" do
    assert_difference('TmpProyecto.count', -1) do
      delete :destroy, id: @tmp_proyecto
    end

    assert_redirected_to tmp_proyectos_path
  end
end
