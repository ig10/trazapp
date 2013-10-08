require 'test_helper'

class TmpActividadsControllerTest < ActionController::TestCase
  setup do
    @tmp_actividad = tmp_actividades(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tmp_actividades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tmp_actividad" do
    assert_difference('TmpActividad.count') do
      post :create, tmp_actividad: { complejidad: @tmp_actividad.complejidad, estado: @tmp_actividad.estado, funcionalidad: @tmp_actividad.funcionalidad, modulo: @tmp_actividad.modulo, proyecto_id: @tmp_actividad.proyecto_id, revision: @tmp_actividad.revision }
    end

    assert_redirected_to tmp_actividad_path(assigns(:tmp_actividad))
  end

  test "should show tmp_actividad" do
    get :show, id: @tmp_actividad
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tmp_actividad
    assert_response :success
  end

  test "should update tmp_actividad" do
    put :update, id: @tmp_actividad, tmp_actividad: { complejidad: @tmp_actividad.complejidad, estado: @tmp_actividad.estado, funcionalidad: @tmp_actividad.funcionalidad, modulo: @tmp_actividad.modulo, proyecto_id: @tmp_actividad.proyecto_id, revision: @tmp_actividad.revision }
    assert_redirected_to tmp_actividad_path(assigns(:tmp_actividad))
  end

  test "should destroy tmp_actividad" do
    assert_difference('TmpActividad.count', -1) do
      delete :destroy, id: @tmp_actividad
    end

    assert_redirected_to tmp_actividades_path
  end
end
