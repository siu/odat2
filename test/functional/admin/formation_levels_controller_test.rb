require 'test_helper'

class Admin::FormationLevelsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:formation_levels)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_formation_level
    FormationLevel.any_instance.stubs(:valid?).returns(:true)
    assert_difference('FormationLevel.count') do
      post :create, :formation_level => { 
	:name => 'Nivel 1'
      }
    end

    assert_redirected_to admin_formation_level_path(assigns(:formation_level))
  end

  def test_should_show_formation_level
    get :show, :id => formation_levels(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => formation_levels(:one).id
    assert_response :success
  end

  def test_should_update_formation_level
    FormationLevel.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => formation_levels(:one).id, :formation_level => { }
    assert_redirected_to admin_formation_level_path(assigns(:formation_level))
  end

  def test_should_destroy_formation_level
    assert_difference('FormationLevel.count', -1) do
      delete :destroy, :id => formation_levels(:one).id
    end

    assert_redirected_to admin_formation_levels_path
  end
end
