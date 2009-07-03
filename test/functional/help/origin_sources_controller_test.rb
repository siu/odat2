require 'test_helper'

class Help::OriginSourcesControllerTest < ActionController::TestCase
  test "should get index" do
    login_as_user
    get :index
    assert_response :success
  end
end
