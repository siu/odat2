require 'test_helper'

class ComparativeReportsControllerTest < ActionController::TestCase
  test "should get index" do
    login_as_user
    get :index
    assert_response :success
    assert_not_nil assigns(:comparative_reports)
  end

  test "should get new" do
    login_as_user
    get :new
    assert_response :success
  end

  test "should create comparative_report" do
    login_as_user
    ComparativeReport.any_instance.stubs(:valid?).returns(:true)
    assert_difference('ComparativeReport.count') do
      post :create, :comparative_report => { }
    end

    assert_redirected_to comparative_report_path(assigns(:comparative_report))
  end

  test "should show comparative_report" do
    login_as_user
    get :show, :id => comparative_reports(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as_user
    get :edit, :id => comparative_reports(:one).to_param
    assert_response :success
  end

  test "should update comparative_report" do
    login_as_user
    ComparativeReport.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => comparative_reports(:one).to_param, :comparative_report => { }
    assert_redirected_to comparative_report_path(assigns(:comparative_report))
  end

  test "should destroy comparative_report" do
    login_as_user
    assert_difference('ComparativeReport.count', -1) do
      delete :destroy, :id => comparative_reports(:one).to_param
    end

    assert_redirected_to comparative_reports_path
  end

end
