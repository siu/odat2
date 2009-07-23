require 'test_helper'

class Admin::SchoolTypesControllerTest < ActionController::TestCase
  include MyApp::Admin::NotLoggedInChecks
  include MyApp::Admin::UserLoggedInChecks

  test "should get index" do
    login_as_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:school_types)
  end

  test "should get new" do
    login_as_admin
    get :new
    assert_response :success
  end

  test "should create school_type" do
    login_as_admin
    SchoolType.any_instance.stubs(:valid?).returns(:true)
    assert_difference('SchoolType.count') do
      post :create, :school_type => { }
    end

    assert_redirected_to school_type_path(assigns(:school_type))
  end

  test "should show school_type" do
    login_as_admin
    get :show, :id => school_types(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as_admin
    get :edit, :id => school_types(:one).to_param
    assert_response :success
  end

  test "should update school_type" do
    login_as_admin
    SchoolType.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => school_types(:one).to_param, :school_type => { }
    assert_redirected_to school_type_path(assigns(:school_type))
  end

  test "should destroy school_type" do
    login_as_admin
    SchoolType.any_instance.stubs(:valid?).returns(:true)
    assert_difference('SchoolType.count', -1) do
      delete :destroy, :id => school_types(:one).to_param
    end

    assert_redirected_to school_types_path
  end
end
