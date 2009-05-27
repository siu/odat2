require 'test_helper'

class Admin::DashboardControllerTest < ActionController::TestCase
  test "shoul reply not found if not logged in" do
    get :index
    assert_response :not_found
  end

  test "shoul reply not found if logged in as user" do
    login_as_user
    get :index
    assert_response :not_found
  end

  test "shoul render index if logged in as admin" do
    login_as_admin
    get :index
    assert_response :success
  end
end
