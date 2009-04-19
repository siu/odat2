require 'test_helper'

class Admin::PagesControllerTest < ActionController::TestCase
  include MyApp::Admin::NotLoggedInChecks
  include MyApp::Admin::UserLoggedInChecks

  test "should get index" do
    login_as_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:pages)
  end

  test "should get new" do
    login_as_admin
    get :new
    assert_response :success
  end

  test "should create page" do
    login_as_admin
    Page.any_instance.stubs(:valid?).returns(:true)
    assert_difference('Page.count') do
      post :create, :page => { }
    end

    assert_redirected_to admin_page_path(assigns(:page))
  end

  test "should show page" do
    login_as_admin
    get :show, :id => pages(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as_admin
    get :edit, :id => pages(:one).to_param
    assert_response :success
  end

  test "should update page" do
    login_as_admin
    Page.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => pages(:one).to_param, :page => { }
    assert_redirected_to admin_page_path(assigns(:page))
  end

  test "should destroy page" do
    login_as_admin
    assert_difference('Page.count', -1) do
      delete :destroy, :id => pages(:one).to_param
    end

    assert_redirected_to admin_pages_path
  end
end
