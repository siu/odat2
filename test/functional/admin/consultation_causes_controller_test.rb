require 'test_helper'

class Admin::ConsultationCausesControllerTest < ActionController::TestCase
  include MyApp::Admin::NotLoggedInChecks
  include MyApp::Admin::UserLoggedInChecks

  def test_should_get_index
    login_as_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:consultation_causes)
  end

  def test_should_get_new
    login_as_admin
    get :new
    assert_response :success
  end

  def test_should_create_consultation_cause
    login_as_admin
    ConsultationCause.any_instance.stubs(:valid?).returns(:true)
    assert_difference('ConsultationCause.count') do
      post :create, :consultation_cause => { }
    end

    assert_redirected_to admin_consultation_cause_path(assigns(:consultation_cause))
  end

  def test_should_show_consultation_cause
    login_as_admin
    get :show, :id => consultation_causes(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as_admin
    get :edit, :id => consultation_causes(:one).id
    assert_response :success
  end

  def test_should_update_consultation_cause
    login_as_admin
    ConsultationCause.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => consultation_causes(:one).id, :consultation_cause => { }
    assert_redirected_to admin_consultation_cause_path(assigns(:consultation_cause))
  end

  def test_should_destroy_consultation_cause
    login_as_admin
    assert_difference('ConsultationCause.count', -1) do
      delete :destroy, :id => consultation_causes(:one).id
    end

    assert_redirected_to admin_consultation_causes_path
  end
end
