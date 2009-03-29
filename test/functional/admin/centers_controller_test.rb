require 'test_helper'

class Admin::CentersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:centers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_center
    Center.any_instance.stubs(:valid?).returns(:true)
    assert_difference('Center.count') do
      post :create, :center => {  :name => 'test1',
				  :region => regions(:demo) }
    end

    assert_redirected_to admin_center_path(assigns(:center))
  end

  def test_should_show_center
    get :show, :id => centers(:madrid).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => centers(:madrid).id
    assert_response :success
  end

  def test_should_update_center
    Center.any_instance.stubs(:valid?).returns(:true)
    put :update,  :id => centers(:madrid).id, 
		  :center => {	:name => 'updated',
				:region => regions(:demo) }
    assert_redirected_to admin_center_path(assigns(:center))
  end

  def test_should_destroy_center
    assert_difference('Center.count', -1) do
      delete :destroy, :id => centers(:madrid).id
    end

    assert_redirected_to admin_centers_path
  end
end
