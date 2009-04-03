require 'test_helper'

class Admin::ProvincesControllerTest < ActionController::TestCase
  include MyApp::Admin::NotLoggedInChecks
  include MyApp::Admin::UserLoggedInChecks

  def test_should_get_index
    login_as_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:provinces)
  end

  def test_should_get_new
    login_as_admin
    get :new
    assert_response :success
  end

  def test_should_create_province
    Province.any_instance.stubs(:valid?).returns(:true)

    login_as_admin
    assert_difference('Province.count') do
      post :create, :province => { }
    end

    assert_redirected_to admin_province_path(assigns(:province))
  end

  def test_should_show_province
    login_as_admin
    get :show, :id => provinces(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as_admin
    get :edit, :id => provinces(:one).id
    assert_response :success
  end

  def test_should_update_province
    Province.any_instance.stubs(:valid?).returns(:true)

    login_as_admin
    put :update, :id => provinces(:one).id, :province => { }
    assert_redirected_to admin_province_path(assigns(:province))
  end

  def test_should_destroy_province
    login_as_admin
    assert_difference('Province.count', -1) do
      delete :destroy, :id => provinces(:one).id
    end

    assert_redirected_to admin_provinces_path
  end
end
