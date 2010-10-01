require 'test_helper'

class MedicalRecordsControllerTest < ActionController::TestCase
  include NotLoggedInChecks

  def test_should_get_index
    login_as_user
    get :index
    assert_response :success
    assert_not_nil assigns(:medical_records)
  end

  def test_should_get_index_only_medical_records_of_center_demo
    login_as :demo
    get :index
    assert_response :success
    assert_not_nil assigns(:medical_records)
  end

  def test_should_get_index_only_medical_records_of_center_demo2
    login_as :user2
    get :index
    assert_response :success
    assert_not_nil assigns(:medical_records)
  end

  def test_should_get_index_when_no_records
    MedicalRecord.delete_all

    login_as_user
    get :index
    assert_response :success
    assert_not_nil assigns(:medical_records)
  end

  def test_should_get_new
    login_as_user
    get :new
    assert_response :success
  end

  def test_should_create_medical_record
    login_as_user
    MedicalRecord.any_instance.stubs(:valid?).returns(:true)
    assert_difference('MedicalRecord.count') do
      post :create, :medical_record => { 
	:name => 'a',
	:surname => 'b'
      }
    end

    assert_redirected_to medical_record_path(assigns(:medical_record))
  end

  test "should create new medical_records for the same center as the user" do
    login_as_user
    MedicalRecord.any_instance.stubs(:valid?).returns(:true)
    assert_difference('MedicalRecord.count') do
      post :create, :medical_record => { 
	:name => 'a',
	:surname => 'b'
      }
    end

    assert_redirected_to medical_record_path(assigns(:medical_record))
    assert_equal assigns(:medical_record).center, current_user.center
  end

  def test_should_show_medical_record
    login_as_user
    get :show, :id => medical_records(:pedrito).id
    assert_response :success
  end

  def test_should_not_show_medical_record_if_not_owned
    login_as_user
    get :show, :id => medical_records(:paco).id
    assert_redirected_to medical_records_path
  end

  def test_should_get_edit
    login_as_user
    get :edit, :id => medical_records(:pedrito).id
    assert_response :success
  end

  def test_should_not_get_edit_if_not_owned
    login_as_user
    get :edit, :id => medical_records(:paco).id
    assert_redirected_to medical_records_path
  end

  def test_should_update_medical_record
    login_as_user
    MedicalRecord.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => medical_records(:pedrito).id, :medical_record => 
    {
      :center_id => centers(:demo).id,
      :name => 'a',
      :surname => 'b'
    }
    assert_redirected_to medical_record_path(assigns(:medical_record))
  end

  def test_should_not_update_medical_record_if_not_owned
    login_as_user
    MedicalRecord.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => medical_records(:paco).id, :medical_record => 
    {
      :center_id => centers(:demo).id,
      :name => 'a',
      :surname => 'b'
    }
    assert_redirected_to medical_records_path
  end

  def test_should_destroy_medical_record
    login_as_user
    assert_difference('MedicalRecord.count', -1) do
      delete :destroy, :id => medical_records(:pedrito).id
    end

    assert_redirected_to medical_records_path
  end

  def test_should_not_destroy_medical_record_if_not_owned
    login_as_user
    assert_no_difference('MedicalRecord.count') do
      delete :destroy, :id => medical_records(:paco).id
    end

    assert_redirected_to medical_records_path
  end

  # CSV tests
  
  def test_should_show_medical_record_csv_format
    login_as_user
    get :show, :id => medical_records(:pedrito).id, :format => 'csv'
    assert_response :success
  end

  def test_should_get_index_csv_format
    login_as_user
    get :index, :format => 'csv'
    assert_response :success
    assert_not_nil assigns(:medical_records)
    assert_equal users(:demo).center.medical_records.count, 
                 assigns(:medical_records).count
  end

  test "show_full.csv should produce a csv file" do
    login_as_user
    get :show_full, :id => medical_records(:pedrito).id, :format => 'csv'
    assert_response :success
  end

  test "index_full.csv should assign medical_records" do
    login_as_user
    get :index_full, :format => 'csv'
    assert_response :success
    assert_not_nil assigns(:medical_records)
    assert_equal users(:demo).center.medical_records.count, 
                 assigns(:medical_records).count
  end

end
