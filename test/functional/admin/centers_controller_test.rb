require 'test_helper'

class Admin::CentersControllerTest < ActionController::TestCase
  include MyApp::Admin::NotLoggedInChecks
  include MyApp::Admin::UserLoggedInChecks

  def test_should_get_index
    login_as_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:centers)
  end

  def test_should_get_new
    login_as_admin
    get :new
    assert_response :success
  end

  def test_should_create_center
    login_as_admin
    Center.any_instance.stubs(:valid?).returns(:true)
    assert_difference('Center.count') do
      post :create, :center => { 
	:name => 'test',
	:region_id => regions(:demo).id
      }
    end

    assert_redirected_to admin_center_path(assigns(:center))
  end

  def test_should_show_center
    login_as_admin
    get :show, :id => centers(:demo).id
    assert_response :success
  end

  def test_should_get_edit
    login_as_admin
    get :edit, :id => centers(:demo).id
    assert_response :success
  end

  def test_should_update_center
    login_as_admin
    Center.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => centers(:demo).id, :center => { }
    assert_redirected_to admin_center_path(assigns(:center))
  end

  def test_should_destroy_center
    login_as_admin
    assert_difference('Center.count', -1) do
      delete :destroy, :id => centers(:demo).id
    end

    assert_redirected_to admin_centers_path
  end
end
