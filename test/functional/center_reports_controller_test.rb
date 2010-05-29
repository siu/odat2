require 'test_helper'

class CenterReportsControllerTest < ActionController::TestCase
  test "should get index" do
    login_as_user
    get :index
    assert_response :success
    assert_not_nil assigns(:center_reports)
  end

  test "should get new" do
    login_as_user
    get :new
    assert_response :success
  end

  test "should create center_report" do
    login_as_user
    CenterReport.any_instance.stubs(:valid?).returns(:true)
    assert_difference('CenterReport.count') do
      post :create, :center_report => { }
    end

    assert_redirected_to center_report_path(assigns(:center_report))
  end

  test "should show center_report" do
    login_as_user
    get :show, :id => comparative_reports(:center_report1).to_param
    assert_response :success
  end

  test "should download center report pdf" do
    login_as_user
    get :show, 
        :id => comparative_reports(:center_report1).to_param, 
        :format => 'pdf'
    assert_response :success
  end

  test "should get edit" do
    login_as_user
    get :edit, :id => comparative_reports(:center_report1).to_param
    assert_response :success
  end

  test "should update center_report" do
    login_as_user
    CenterReport.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => comparative_reports(:center_report1).to_param, :center_report => { }
    assert_redirected_to center_report_path(assigns(:center_report))
  end

  test "should destroy center_report" do
    login_as_user
    CenterReport.any_instance.stubs(:valid?).returns(:true)
    assert_difference('CenterReport.count', -1) do
      delete :destroy, :id => comparative_reports(:center_report1).to_param
    end

    assert_redirected_to center_reports_path
  end
end
