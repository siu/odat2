require 'test_helper'

class Admin::RegionsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:regions)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_region
    Region.any_instance.stubs(:valid?).returns(:true)
    assert_difference('Region.count') do
      post :create, :region => { :name => 'New Region' }
    end

    assert_redirected_to admin_region_path(assigns(:region))
  end

  def test_should_show_region
    get :show, :id => regions(:madrid).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => regions(:madrid).id
    assert_response :success
  end

  def test_should_update_region
    Region.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => regions(:madrid).id, :region => { 
	    :name => 'Updated region' }
    assert_redirected_to admin_region_path(assigns(:region))
  end

  def test_should_destroy_region
    assert_difference('Region.count', -1) do
      delete :destroy, :id => regions(:madrid).id
    end

    assert_redirected_to admin_regions_path
  end
end
