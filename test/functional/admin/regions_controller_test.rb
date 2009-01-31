require 'test_helper'

class Admin::RegionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:regions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create region" do
    assert_difference('Region.count') do
      post :create, :region => { :name => 'New Region' }
    end

    assert_redirected_to admin_region_path(assigns(:region))
  end

  test "should show region" do
    get :show, :id => regions(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => regions(:one).id
    assert_response :success
  end

  test "should update region" do
    put :update, :id => regions(:one).id, :region => { 
	    :name => 'Updated region' }
    assert_redirected_to admin_region_path(assigns(:region))
  end

  test "should destroy region" do
    assert_difference('Region.count', -1) do
      delete :destroy, :id => regions(:one).id
    end

    assert_redirected_to admin_regions_path
  end
end
