require 'test_helper'

class Admin::CivilStatesControllerTest < ActionController::TestCase
  include MyApp::Admin::NotLoggedInChecks
  include MyApp::Admin::UserLoggedInChecks

  def test_should_get_index
    login_as_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:civil_states)
  end

  def test_should_get_new
    login_as_admin
    get :new
    assert_response :success
  end

  def test_should_create_civil_state
    login_as_admin
    CivilState.any_instance.stubs(:valid?).returns(:true)
    assert_difference('CivilState.count') do
      post :create, :civil_state => { 
      }
    end

    assert_redirected_to admin_civil_state_path(assigns(:civil_state))
  end

  def test_should_show_civil_state
    login_as_admin
    get :show, :id => civil_states(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as_admin
    get :edit, :id => civil_states(:one).id
    assert_response :success
  end

  def test_should_update_civil_state
    login_as_admin
    CivilState.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => civil_states(:one).id, :civil_state => { }
    assert_redirected_to admin_civil_state_path(assigns(:civil_state))
  end

  def test_should_destroy_civil_state
    login_as_admin
    assert_difference('CivilState.count', -1) do
      delete :destroy, :id => civil_states(:one).id
    end

    assert_redirected_to admin_civil_states_path
  end
end
