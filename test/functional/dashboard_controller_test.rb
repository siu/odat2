require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  should "render index if logged in" do
    login_as_user
    get :index
    assert_response :success
  end

  should "redirect to login if not logged in" do
    get :index
    assert_redirected_to login_url
  end
end
