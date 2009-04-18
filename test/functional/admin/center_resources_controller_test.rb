require 'test_helper'

class Admin::CenterResourcesControllerTest < ActionController::TestCase
  include MyApp::Admin::NotLoggedInChecks
  include MyApp::Admin::UserLoggedInChecks

  test "should get index" do
    login_as_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:center_resources)
  end

  test "should get new" do
    login_as_admin
    get :new
    assert_response :success
  end

  test "should create center_resource" do
    login_as_admin
    CenterResource.any_instance.stubs(:valid?).returns(:true)
    assert_difference('CenterResource.count') do
      post :create, :center_resource => { }
    end

    assert_redirected_to admin_center_resource_path(assigns(:center_resource))
  end

  test "should show center_resource" do
    login_as_admin
    get :show, :id => center_resources(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as_admin
    get :edit, :id => center_resources(:one).to_param
    assert_response :success
  end

  test "should update center_resource" do
    login_as_admin
    CenterResource.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => center_resources(:one).to_param, :center_resource => { }
    assert_redirected_to admin_center_resource_path(assigns(:center_resource))
  end

  test "should destroy center_resource" do
    login_as_admin
    assert_difference('CenterResource.count', -1) do
      delete :destroy, :id => center_resources(:one).to_param
    end

    assert_redirected_to admin_center_resources_path
  end
end
