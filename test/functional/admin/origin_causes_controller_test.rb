require 'test_helper'

class Admin::OriginCausesControllerTest < Admin::AdminSectionControllerTest
  include MyApp::Admin::NotLoggedInChecks
  include MyApp::Admin::UserLoggedInChecks

  def test_should_get_index
    login_as_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:origin_causes)
  end

  def test_should_get_new
    login_as_admin
    get :new
    assert_response :success
  end

  def test_should_create_origin_cause
    login_as_admin
    OriginCause.any_instance.stubs(:valid?).returns(:true)
    assert_difference('OriginCause.count') do
      post :create, :origin_cause => { }
    end

    assert_redirected_to admin_origin_cause_path(assigns(:origin_cause))
  end

  def test_should_show_origin_cause
    login_as_admin
    get :show, :id => origin_causes(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as_admin
    get :edit, :id => origin_causes(:one).id
    assert_response :success
  end

  def test_should_update_origin_cause
    login_as_admin
    OriginCause.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => origin_causes(:one).id, :origin_cause => { }
    assert_redirected_to admin_origin_cause_path(assigns(:origin_cause))
  end

  def test_should_destroy_origin_cause
    login_as_admin
    assert_difference('OriginCause.count', -1) do
      delete :destroy, :id => origin_causes(:one).id
    end

    assert_redirected_to admin_origin_causes_path
  end
end
