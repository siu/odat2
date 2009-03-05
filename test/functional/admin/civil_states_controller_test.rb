require 'test_helper'

class Admin::CivilStatesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:civil_states)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_civil_state
    assert_difference('CivilState.count') do
      post :create, :civil_state => { }
    end

    assert_redirected_to admin_civil_state_path(assigns(:civil_state))
  end

  def test_should_show_civil_state
    get :show, :id => civil_states(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => civil_states(:one).id
    assert_response :success
  end

  def test_should_update_civil_state
    put :update, :id => civil_states(:one).id, :civil_state => { }
    assert_redirected_to admin_civil_state_path(assigns(:civil_state))
  end

  def test_should_destroy_civil_state
    assert_difference('CivilState.count', -1) do
      delete :destroy, :id => civil_states(:one).id
    end

    assert_redirected_to admin_civil_states_path
  end
end
