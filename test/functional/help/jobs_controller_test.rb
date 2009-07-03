require 'test_helper'

class Help::JobsControllerTest < ActionController::TestCase
  test "should get index" do
    login_as_user
    get :index
    assert_response :success
  end
end
