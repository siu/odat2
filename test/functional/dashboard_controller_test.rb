require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  should "render index" do
    get :index
    assert_response :success
  end
end
