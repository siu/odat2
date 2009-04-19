require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should show page" do
    get :show, :permalink => pages(:docs).permalink
    assert_response :success
  end
end
