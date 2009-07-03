require 'test_helper'

class Help::DiagnosisItemsControllerTest < ActionController::TestCase
  test "should get index" do
    login_as_user
    get :index
    assert_response :success
  end

  test "should get show for a category" do
    login_as_user
    get :show, :id => diagnosis_items(:c1).id
    assert_response :success
  end

  test "should get show for a subcategory" do
    login_as_user
    get :show, :id => diagnosis_items(:s1_1).id
    assert_response :success
  end
end
