require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  test "should render index if logged in" do
    login_as_user
    get :index
    assert_response :success
  end

  test "should redirect to login if not logged in" do
    get :index
    assert_redirected_to login_url
  end
end
