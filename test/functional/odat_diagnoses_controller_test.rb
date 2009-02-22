require 'test_helper'

class OdatDiagnosesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index, :medical_record_id => medical_records(:pedrito).id
    assert_response :success
    assert_not_nil assigns(:odat_diagnoses)
  end

  def test_should_get_new
    get :new, :medical_record_id => medical_records(:pedrito).id
    assert_response :success
  end

  def test_should_create_odat_diagnosis
    assert_difference('OdatDiagnosis.count') do
      post :create, 
	:medical_record_id => medical_records(:pedrito).id, 
	:odat_diagnosis => {
	  :medical_record_id => medical_records(:pedrito).id, 
	}
    end

    assert_redirected_to 
    	medical_record_odat_diagnosis_path({:medical_record_id => medical_records(:pedrito)}, assigns(:odat_diagnosis))
  end

  def test_should_show_odat_diagnosis
    get :show, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id
    assert_response :success
  end

  def test_should_update_odat_diagnosis
    put :update, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id, 
	:odat_diagnosis => { 
	  :medical_record_id => medical_records(:pedrito).id, 
	}
    assert_redirected_to 
    	medical_record_odat_diagnosis_path(
	    {:medical_record_id => medical_records(:pedrito).id},
	    assigns(:odat_diagnosis))
  end

  def test_should_destroy_odat_diagnosis
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
