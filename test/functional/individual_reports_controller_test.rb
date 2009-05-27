require 'test_helper'

class IndividualReportsControllerTest < ActionController::TestCase
  include NotLoggedInChecks

  include IndividualReportsHelper

  test "should get index" do
    login_as_user
    get :index, 
      :medical_record_id => medical_records(:pedrito).id
    assert_response :success
    assert_not_nil assigns(:individual_reports)
  end

  test "should get new" do
    login_as_user
    get :new,
      :medical_record_id => medical_records(:pedrito).id
    assert_response :success
  end

  test "should create individual_report" do
    login_as_user
    IndividualReport.any_instance.stubs(:valid?).returns(:true)
    assert_difference('IndividualReport.count') do
      post :create, 
        :medical_record_id => medical_records(:pedrito).id, 
        :individual_report => { }
    end

    assert_redirected_to(
      individual_report_path(assigns(:individual_report)))
  end

  test "should show individual_report" do
    login_as_user
    get :show, 
      :medical_record_id => medical_records(:pedrito).id, 
      :id => individual_reports(:one).to_param
    assert_response :success
  end

  test "should download individual_report pdf" do
    login_as_user
    get :show, 
      { :medical_record_id => medical_records(:pedrito).to_param, 
        :id => individual_reports(:one).to_param, 
        :format => 'pdf'}
    assert_response :success
  end

  test "should get edit" do
    login_as_user
    get :edit, 
      :medical_record_id => medical_records(:pedrito).id, 
      :id => individual_reports(:one).to_param
    assert_response :success
  end

  test "should update individual_report" do
    login_as_user
    IndividualReport.any_instance.stubs(:valid?).returns(:true)
    put :update, 
      :medical_record_id => medical_records(:pedrito).id, 
      :id => individual_reports(:one).to_param, 
      :individual_report => { }
    assert_redirected_to(
      medical_record_individual_report_path(
        individual_reports(:one).medical_record_id,
        individual_reports(:one).id))
  end

  test "should destroy individual_report" do
    login_as_user
    IndividualReport.any_instance.stubs(:valid?).returns(:true)
    assert_difference('IndividualReport.count', -1) do
      delete :destroy, 
        :medical_record_id => medical_records(:pedrito).id, 
        :id => individual_reports(:one).to_param
    end

    assert_redirected_to medical_record_individual_reports_path
  end

  # More tests on show action
  test "should show individual_report with full details" do
    login_as_user
    get :show, 
      :medical_record_id => medical_records(:pedrito).id, 
      :id => individual_reports(:two).to_param
    assert_response :success
  end
end
