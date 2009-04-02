require 'test_helper'

class Admin::DiagnosisItemsControllerTest < ActionController::TestCase
  include MyApp::Admin::NotLoggedInChecks
  include MyApp::Admin::UserLoggedInChecks

  def test_should_get_index
    login_as_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:diagnosis_items)
  end

  def test_should_get_new
    login_as_admin
    get :new
    assert_response :success
  end

  def test_should_create_diagnosis_item
    login_as_admin
    DiagnosisItem.any_instance.stubs(:valid?).returns(:true)
    assert_difference('DiagnosisItem.count') do
      post :create, :diagnosis_item => { }
    end

    assert_redirected_to admin_diagnosis_item_path(assigns(:diagnosis_item))
  end

  def test_should_show_diagnosis_item
    login_as_admin
    get :show, :id => diagnosis_items(:c1).id
    assert_response :success
  end

  def test_should_get_edit
    login_as_admin
    get :edit, :id => diagnosis_items(:c1).id
    assert_response :success
  end

  def test_should_update_diagnosis_item
    login_as_admin
    DiagnosisItem.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => diagnosis_items(:c1).id, :diagnosis_item => { }
    assert_redirected_to admin_diagnosis_item_path(assigns(:diagnosis_item))
  end

  def test_should_destroy_diagnosis_item
    login_as_admin
    assert_difference('DiagnosisItem.count', -1) do
      delete :destroy, :id => diagnosis_items(:e1_1_1).id
    end

    assert_redirected_to admin_diagnosis_items_path
  end

  def test_should_destroy_children_items
    login_as_admin
    assert_difference('DiagnosisItem.count', -3) do
      delete :destroy, :id => diagnosis_items(:s1_1).id
    end

    assert_redirected_to admin_diagnosis_items_path
  end
end
