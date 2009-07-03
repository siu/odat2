require 'test_helper'

class Help::OriginCausesControllerTest < ActionController::TestCase
  test "should get index" do
    login_as_user
    get :index
    assert_response :success
  end
end
