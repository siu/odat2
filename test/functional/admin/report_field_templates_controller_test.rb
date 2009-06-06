require 'test_helper'

class Admin::ReportFieldTemplatesControllerTest < ActionController::TestCase
  include MyApp::Admin::NotLoggedInChecks
  include MyApp::Admin::UserLoggedInChecks

  test "should get index" do
    login_as_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:report_field_templates)
  end

  test "should get new" do
    login_as_admin
    get :new
    assert_response :success
  end

  test "should create report_field_template" do
    login_as_admin
    ReportFieldTemplate.any_instance.stubs(:valid?).returns(:true)
    assert_difference('ReportFieldTemplate.count') do
      post :create, :report_field_template => { }
    end

    assert_redirected_to report_field_template_path(assigns(:report_field_template))
  end

  test "should show report_field_template" do
    login_as_admin
    get :show, :id => report_field_templates(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as_admin
    get :edit, :id => report_field_templates(:one).to_param
    assert_response :success
  end

  test "should update report_field_template" do
    login_as_admin
    ReportFieldTemplate.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => report_field_templates(:one).to_param, :report_field_template => { }
    assert_redirected_to report_field_template_path(assigns(:report_field_template))
  end

  test "should destroy report_field_template" do
    login_as_admin
    assert_difference('ReportFieldTemplate.count', -1) do
      delete :destroy, :id => report_field_templates(:one).to_param
    end

    assert_redirected_to report_field_templates_path
  end
end
