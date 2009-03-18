require 'test_helper'

class Admin::ConsultationCausesControllerTest < Admin::AdminSectionControllerTest
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:consultation_causes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_consultation_cause
    ConsultationCause.any_instance.stubs(:valid?).returns(:true)
    assert_difference('ConsultationCause.count') do
      post :create, :consultation_cause => { }
    end

    assert_redirected_to admin_consultation_cause_path(assigns(:consultation_cause))
  end

  def test_should_show_consultation_cause
    get :show, :id => consultation_causes(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => consultation_causes(:one).id
    assert_response :success
  end

  def test_should_update_consultation_cause
    ConsultationCause.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => consultation_causes(:one).id, :consultation_cause => { }
    assert_redirected_to admin_consultation_cause_path(assigns(:consultation_cause))
  end

  def test_should_destroy_consultation_cause
    assert_difference('ConsultationCause.count', -1) do
      delete :destroy, :id => consultation_causes(:one).id
    end

    assert_redirected_to admin_consultation_causes_path
  end
end
