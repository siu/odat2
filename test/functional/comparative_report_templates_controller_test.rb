require 'test_helper'

class ComparativeReportTemplatesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comparative_report_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comparative_report_template" do
    assert_difference('ComparativeReportTemplate.count') do
      post :create, :comparative_report_template => { }
    end

    assert_redirected_to comparative_report_template_path(assigns(:comparative_report_template))
  end

  test "should show comparative_report_template" do
    get :show, :id => comparative_report_templates(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => comparative_report_templates(:one).to_param
    assert_response :success
  end

  test "should update comparative_report_template" do
    put :update, :id => comparative_report_templates(:one).to_param, :comparative_report_template => { }
    assert_redirected_to comparative_report_template_path(assigns(:comparative_report_template))
  end

  test "should destroy comparative_report_template" do
    assert_difference('ComparativeReportTemplate.count', -1) do
      delete :destroy, :id => comparative_report_templates(:one).to_param
    end

    assert_redirected_to comparative_report_templates_path
  end
end
