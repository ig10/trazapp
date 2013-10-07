require 'test_helper'

class TmpGroupsControllerTest < ActionController::TestCase
  setup do
    @tmp_group = tmp_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tmp_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tmp_group" do
    assert_difference('TmpGroup.count') do
      post :create, tmp_group: { activities_hash: @tmp_group.activities_hash, estado: @tmp_group.estado, nombre_proyecto: @tmp_group.nombre_proyecto, users_hash: @tmp_group.users_hash }
    end

    assert_redirected_to tmp_group_path(assigns(:tmp_group))
  end

  test "should show tmp_group" do
    get :show, id: @tmp_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tmp_group
    assert_response :success
  end

  test "should update tmp_group" do
    put :update, id: @tmp_group, tmp_group: { activities_hash: @tmp_group.activities_hash, estado: @tmp_group.estado, nombre_proyecto: @tmp_group.nombre_proyecto, users_hash: @tmp_group.users_hash }
    assert_redirected_to tmp_group_path(assigns(:tmp_group))
  end

  test "should destroy tmp_group" do
    assert_difference('TmpGroup.count', -1) do
      delete :destroy, id: @tmp_group
    end

    assert_redirected_to tmp_groups_path
  end
end
