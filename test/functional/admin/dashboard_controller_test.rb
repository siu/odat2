require 'test_helper'

class Admin::DashboardControllerTest < ActionController::TestCase
  should "reply not found if not logged in" do
    get :index
    assert_response :not_found
  end

  should "reply not found if logged in as user" do
    login_as_user
    get :index
    assert_response :not_found
  end

  should "render index if logged in as admin" do
    login_as_admin
    get :index
    assert_response :success
  end
end
