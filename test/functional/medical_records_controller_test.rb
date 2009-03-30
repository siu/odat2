require 'test_helper'

class MedicalRecordsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:medical_records)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_medical_record
    MedicalRecord.any_instance.stubs(:valid?).returns(:true)
    assert_difference('MedicalRecord.count') do
      post :create, :medical_record => { 
	:center_id => centers(:demo).id,
	:name => 'a',
	:surname => 'b'
      }
    end

    assert_redirected_to medical_record_path(assigns(:medical_record))
  end

  def test_should_show_medical_record
    get :show, :id => medical_records(:pedrito).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => medical_records(:pedrito).id
    assert_response :success
  end

  def test_should_update_medical_record
    MedicalRecord.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => medical_records(:pedrito).id, :medical_record => 
    {
      :center_id => centers(:demo).id,
      :name => 'a',
      :surname => 'b'
    }
    assert_redirected_to medical_record_path(assigns(:medical_record))
  end

  def test_should_destroy_medical_record
    assert_difference('MedicalRecord.count', -1) do
      delete :destroy, :id => medical_records(:pedrito).id
    end

    assert_redirected_to medical_records_path
  end
end
