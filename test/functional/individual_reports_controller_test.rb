require 'test_helper'

class IndividualReportsControllerTest < ActionController::TestCase
  def setup
    login_as_user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:individual_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create individual_report" do
    IndividualReport.any_instance.stubs(:valid?).returns(:true)
    assert_difference('IndividualReport.count') do
      post :create, :individual_report => { }
    end

    assert_redirected_to individual_report_path(assigns(:individual_report))
  end

  test "should show individual_report" do
    get :show, :id => individual_reports(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => individual_reports(:one).to_param
    assert_response :success
  end

  test "should update individual_report" do
    IndividualReport.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => individual_reports(:one).to_param, :individual_report => { }
    assert_redirected_to individual_report_path(assigns(:individual_report))
  end

  test "should destroy individual_report" do
    IndividualReport.any_instance.stubs(:valid?).returns(:true)
    assert_difference('IndividualReport.count', -1) do
      delete :destroy, :id => individual_reports(:one).to_param
    end

    assert_redirected_to individual_reports_path
  end
end
