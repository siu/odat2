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

  should "not get index if user is not in the same center as the record" do
    login_as :quentin
    get :index, :medical_record_id => medical_records(:paco).id
    assert_redirected_to medical_records_path
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
    	medical_record_odat_diagnoses_path(
	  {:medical_record_id => medical_records(:pedrito).id}, 
	  assigns(:medical_record))
  end

  should "not create if user is not in the same center as the record" do
    login_as_user
    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)
    assert_no_difference('OdatDiagnosis.count') do
      post :create, 
	:medical_record_id => medical_records(:paco).id, 
	:odat_diagnosis => { }
    end
    assert_redirected_to medical_records_path
  end

  should "allow creation of two odat_diagnosis with the same medical_record" do
    login_as_user

    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)

    items = [diagnosis_items(:e1_1_1).id, diagnosis_items(:e1_1_2).id]

    assert_difference('OdatDiagnosis.count') do
      post :create, 
	:medical_record_id => medical_records(:pedrito).id, 
	:odat_diagnosis => { 
	  :diagnosis_item_ids => items
	}
    end
    assert_response :redirect
    assert_equal items.count, assigns(:odat_diagnosis).diagnosis_items.count

    assert_difference('OdatDiagnosis.count') do
      post :create,
	:medical_record_id => medical_records(:pedrito).id,
	:odat_diagnosis => {
	  :diagnosis_item_ids => items
	}
    end
    assert_response :redirect
    assert_equal items.count, assigns(:odat_diagnosis).diagnosis_items.count
  end

  def test_should_show_odat_diagnosis
    login_as_user
    get :show, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id
    assert_response :success
  end

  should "not show if user not in the same center" do
    login_as :quentin
    get :show, 
	:medical_record_id => medical_records(:paco).id, 
	:id => odat_diagnoses(:one).id
    assert_redirected_to medical_records_path
  end

  def test_should_get_edit
    login_as_user
    get :edit, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id
    assert_response :success
  end

  should "not get edit if user not in the same center" do
    login_as :quentin
    get :edit, 
	:medical_record_id => medical_records(:paco).id, 
	:id => odat_diagnoses(:one).id
    assert_redirected_to medical_records_path
  end

  def test_should_update_odat_diagnosis
    login_as_user
    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)
    put :update, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id, 
	:odat_diagnosis => { }
    assert_redirected_to(
    	medical_record_odat_diagnoses_path(
	    :medical_record_id => medical_records(:pedrito).id))
  end

  should "not update if user not in the same center" do
    login_as :quentin
    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)
    put :update, 
	:medical_record_id => medical_records(:paco).id, 
	:id => odat_diagnoses(:one).id, 
	:odat_diagnosis => { }
    assert_redirected_to medical_records_path
  end
  
  should "update item_diagnosis relations" do
    login_as_user
    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)

    items = [diagnosis_items(:e1_1_1).id, diagnosis_items(:e1_1_2).id]
    put :update, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id, 
	:odat_diagnosis => { :diagnosis_item_ids => items }

    assert_response :redirect
    assert_equal items.count, assigns(:odat_diagnosis).diagnosis_items.count

    items = []
    put :update, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id, 
	:odat_diagnosis => { :diagnosis_item_ids => items }

    assert_response :redirect
    assert_equal items.count, assigns(:odat_diagnosis).diagnosis_items.count

    items = [diagnosis_items(:e1_1_1).id]
    put :update, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id, 
	:odat_diagnosis => { :diagnosis_item_ids => items }

    assert_response :redirect
    assert_equal items.count, assigns(:odat_diagnosis).diagnosis_items.count
  end

  should "update center_resources relations" do
    login_as_user
    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)

    items = [center_resources(:r1).id, center_resources(:r2).id]
    put :update, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id, 
	:odat_diagnosis => { :center_resource_ids => items }

    assert_response :redirect
    assert_equal items.count, assigns(:odat_diagnosis).center_resources.count

    items = [center_resources(:r3).id]
    put :update, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id, 
	:odat_diagnosis => { :center_resource_ids => items }

    assert_response :redirect
    assert_equal items.count, assigns(:odat_diagnosis).center_resources.count
  end

  def test_should_destroy_odat_diagnosis
    login_as_user
    assert_difference('OdatDiagnosis.count', -1) do
      delete :destroy, 
	:medical_record_id => medical_records(:pedrito).id, 
	:id => odat_diagnoses(:one).id
    end

    assert_redirected_to(
    	medical_record_odat_diagnoses_path(
	  :medical_record_id => medical_records(:pedrito).id))
  end

  should "not destroy if user not in the same center" do
    login_as :quentin
    assert_no_difference('OdatDiagnosis.count') do
      delete :destroy, 
	:medical_record_id => medical_records(:paco).id, 
	:id => odat_diagnoses(:one).id
    end
    assert_redirected_to medical_records_path
  end
end
