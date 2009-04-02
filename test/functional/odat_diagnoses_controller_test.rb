require 'test_helper'

class OdatDiagnosesControllerTest < ActionController::TestCase
  include NotLoggedInChecks

  def test_should_get_index
    login_as_user
    get :index, :medical_record_id => medical_records(:pedrito).id
    assert_response :success
    assert_not_nil assigns(:odat_diagnoses)
    assert_equal medical_records(:pedrito).odat_diagnoses.size, 
	    assigns(:odat_diagnoses).size
  end

  def test_should_get_new
    login_as_user
    get :new, :medical_record_id => medical_records(:pedrito).id
    assert_response :success
  end

  def test_should_create_odat_diagnosis
    login_as_user
    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)
    assert_difference('OdatDiagnosis.count') do
      post :create, 
	:medical_record_id => medical_records(:pedrito).id, 
	:odat_diagnosis => { }
    end

    assert_redirected_to 
    	medical_record_odat_diagnosis_path(
	  {:medical_record_id => medical_records(:pedrito).id}, 
	  assigns(:odat_diagnosis))
  end

  def test_should_show_odat_diagnosis
    login_as_user
    get :show, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as_user
    get :edit, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id
    assert_response :success
  end

  def test_should_update_odat_diagnosis
    login_as_user
    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)
    put :update, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id, 
	:odat_diagnosis => { }
    assert_redirected_to 
    	medical_record_odat_diagnosis_path(
	    {:medical_record_id => medical_records(:pedrito).id},
	    assigns(:odat_diagnosis))
  end

  def test_should_destroy_odat_diagnosis
    login_as_user
    assert_difference('OdatDiagnosis.count', -1) do
      delete :destroy, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id
    end

    assert_redirected_to 
    	medical_record_odat_diagnoses_path(
	    :medical_record_id => medical_records(:pedrito).id)
  end
end
