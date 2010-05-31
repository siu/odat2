require 'test_helper'

class Admin::EvaluationCategoriesControllerTest < ActionController::TestCase
  include MyApp::Admin::NotLoggedInChecks
  include MyApp::Admin::UserLoggedInChecks

  test "should get index" do
    login_as_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:evaluation_categories)
  end

  test "should get new" do
    login_as_admin
    get :new
    assert_response :success
  end

  test "should create evaluation_category" do
    EvaluationCategory.any_instance.stubs(:valid?).returns(:true)

    login_as_admin
    assert_difference('EvaluationCategory.count') do
      post :create, :evaluation_category => { :name => "Unnombre" }
    end

    assert_redirected_to evaluation_category_path(assigns(:evaluation_category))
  end

  test "should show evaluation_category" do
    login_as_admin
    get :show, :id => evaluation_categories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as_admin
    get :edit, :id => evaluation_categories(:one).to_param
    assert_response :success
  end

  test "should update evaluation_category" do
    EvaluationCategory.any_instance.stubs(:valid?).returns(:true)

    login_as_admin
    put :update, :id => evaluation_categories(:one).to_param, :evaluation_category => { }
    assert_redirected_to evaluation_category_path(assigns(:evaluation_category))
  end

  test "should destroy evaluation_category" do
    login_as_admin
    assert_difference('EvaluationCategory.count', -1) do
      delete :destroy, :id => evaluation_categories(:one).to_param
    end

    assert_redirected_to evaluation_categories_path
  end
end
