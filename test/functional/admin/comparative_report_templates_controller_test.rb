require 'test_helper'

class Admin::ComparativeReportTemplatesControllerTest < ActionController::TestCase
  include MyApp::Admin::NotLoggedInChecks
  include MyApp::Admin::UserLoggedInChecks

  test "should get index" do
    login_as_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:comparative_report_templates)
  end

  test "should get new" do
    login_as_admin
    get :new
    assert_response :success
  end

  test "should create comparative_report_template" do
    login_as_admin
    ComparativeReportTemplate.any_instance.stubs(:valid?).returns(:true)
    assert_difference('ComparativeReportTemplate.count') do
      post :create, :comparative_report_template => { }
    end

    assert_redirected_to comparative_report_template_path(assigns(:comparative_report_template))
  end

  test "should show comparative_report_template" do
    login_as_admin
    get :show, :id => comparative_report_templates(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as_admin
    get :edit, :id => comparative_report_templates(:one).to_param
    assert_response :success
  end

  test "should update comparative_report_template" do
    login_as_admin
    ComparativeReportTemplate.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => comparative_report_templates(:one).to_param, :comparative_report_template => { }
    assert_redirected_to comparative_report_template_path(assigns(:comparative_report_template))
  end

  test "should create a comparative_report_template with a report_field_template linked" do
    login_as_admin

    ComparativeReportTemplate.any_instance.stubs(:valid?).returns(:true)
    assert_difference('ComparativeReportTemplate.count') do
      post :create, :comparative_report_template => { 
        :name => 'ulala',
        :comparative_report_template_field_assignments_attributes => 
          [
            {:report_field_template_id => report_field_templates(:one).id}
          ]
      }
    end

    assert_redirected_to comparative_report_template_path(assigns(:comparative_report_template))
    assert_equal 1, assigns(:comparative_report_template).report_field_templates.size
  end

  test "should update and mantain associated comparative_report_field" do
    login_as_admin
    ComparativeReportTemplate.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => comparative_report_templates(:one).to_param, 
      :comparative_report_template => { 
        :comparative_report_template_field_assignments_attributes => 
          [
            {:report_field_template_id => report_field_templates(:one).id}
          ]
      }
    assert_redirected_to comparative_report_template_path(assigns(:comparative_report_template))
    assert_equal 1, assigns(:comparative_report_template).report_field_templates.size
  end

  test "should update and remove associated comparative_report_field" do
    login_as_admin
    ComparativeReportTemplate.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => comparative_report_templates(:one).to_param, 
      :comparative_report_template => { 
        :comparative_report_template_field_assignments_attributes => 
          [
            {:_destroy => report_field_templates(:one).id}
          ]
      }
    assert_redirected_to comparative_report_template_path(assigns(:comparative_report_template))
    assert_equal 0, assigns(:comparative_report_template).report_field_templates.size
  end

  test "should update and mantain and remove associated comparative_report_fields 1" do
    login_as_admin

    assert_equal 2, comparative_report_templates(:two).report_field_templates.size
    ComparativeReportTemplate.any_instance.stubs(:valid?).returns(:true)

    put :update, :id => comparative_report_templates(:two).to_param, 
      :comparative_report_template => { 
        :comparative_report_template_field_assignments_attributes => 
          [
            {:report_field_template_id => report_field_templates(:one).id},
            {:_destroy => report_field_templates(:two).id}
          ]
      }

    assert_redirected_to comparative_report_template_path(assigns(:comparative_report_template))
    assert_equal 1, assigns(:comparative_report_template).report_field_templates.size
  end

  test "should update and mantain and remove associated comparative_report_fields 2" do
    login_as_admin

    assert_equal 2, comparative_report_templates(:two).report_field_templates.size
    ComparativeReportTemplate.any_instance.stubs(:valid?).returns(:true)

    put :update, :id => comparative_report_templates(:two).to_param, 
      :comparative_report_template => { 
        :comparative_report_template_field_assignments_attributes => 
          [
            {:report_field_template_id => report_field_templates(:two).id},
            {:_destroy => report_field_templates(:one).id}
          ]
      }

    assert_redirected_to comparative_report_template_path(assigns(:comparative_report_template))
    assert_equal 1, assigns(:comparative_report_template).report_field_templates.size
  end

  test "should destroy comparative_report_template" do
    login_as_admin
    assert_difference('ComparativeReportTemplate.count', -1) do
      delete :destroy, :id => comparative_report_templates(:one).to_param
    end

    assert_redirected_to comparative_report_templates_path
  end
end
