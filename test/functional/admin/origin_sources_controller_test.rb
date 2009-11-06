require 'test_helper'

class Admin::OriginSourcesControllerTest < ActionController::TestCase
  include MyApp::Admin::NotLoggedInChecks
  include MyApp::Admin::UserLoggedInChecks

  def test_should_get_index
    login_as_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:origin_sources)
  end

  def test_should_get_new
    login_as_admin
    get :new
    assert_response :success
  end

  def test_should_create_origin_source
    login_as_admin
    OriginSource.any_instance.stubs(:valid?).returns(:true)
    assert_difference('OriginSource.count') do
      post :create, :origin_source => { }
    end

    assert_redirected_to admin_origin_source_path(assigns(:origin_source))
  end

  def test_should_show_origin_source
    login_as_admin
    get :show, :id => origin_sources(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as_admin
    get :edit, :id => origin_sources(:one).id
    assert_response :success
  end

  def test_should_update_origin_source
    login_as_admin
    OriginSource.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => origin_sources(:one).id, :origin_source => { }
    assert_redirected_to admin_origin_source_path(assigns(:origin_source))
  end

  def test_should_destroy_origin_source
    login_as_admin
    assert_difference('OriginSource.count', -1) do
      delete :destroy, :id => origin_sources(:one).id
    end

    assert_redirected_to admin_origin_sources_path
  end
end
