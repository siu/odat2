require 'test_helper'

class Admin::ComparativeFunctionsControllerTest < ActionController::TestCase
  include MyApp::Admin::NotLoggedInChecks
  include MyApp::Admin::UserLoggedInChecks

  test "should get index" do
    login_as_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:comparative_functions)
  end

  test "should get new" do
    login_as_admin
    get :new
    assert_response :success
  end

  test "should create comparative_function" do
    login_as_admin
    ComparativeFunction.any_instance.stubs(:valid?).returns(:true)
    assert_difference('ComparativeFunction.count') do
      post :create, :comparative_function => { }
    end

    assert_redirected_to comparative_function_path(assigns(:comparative_function))
  end

  test "should show comparative_function" do
    login_as_admin
    get :show, :id => comparative_functions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as_admin
    get :edit, :id => comparative_functions(:one).to_param
    assert_response :success
  end

  test "should update comparative_function" do
    login_as_admin
    ComparativeFunction.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => comparative_functions(:one).to_param, :comparative_function => { }
    assert_redirected_to comparative_function_path(assigns(:comparative_function))
  end

  test "should destroy comparative_function" do
    login_as_admin
    assert_difference('ComparativeFunction.count', -1) do
      delete :destroy, :id => comparative_functions(:one).to_param
    end

    assert_redirected_to comparative_functions_path
  end
end
