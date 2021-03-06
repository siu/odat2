require 'test_helper'

class Admin::JobsControllerTest < ActionController::TestCase
  include MyApp::Admin::NotLoggedInChecks
  include MyApp::Admin::UserLoggedInChecks

  def test_should_get_index
    login_as_admin
    get :index
    assert_response :success
    assert_not_nil assigns(:jobs)
  end

  def test_should_get_new
    login_as_admin
    get :new
    assert_response :success
  end

  def test_should_create_job
    login_as_admin
    Job.any_instance.stubs(:valid?).returns(:true)
    assert_difference('Job.count') do
      post :create, :job => { 
	:name => 'Trabajo 1'
      }
    end

    assert_redirected_to admin_job_path(assigns(:job))
  end

  def test_should_show_job
    login_as_admin
    get :show, :id => jobs(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as_admin
    get :edit, :id => jobs(:one).id
    assert_response :success
  end

  def test_should_update_job
    login_as_admin
    Job.any_instance.stubs(:valid?).returns(:true)
    put :update, :id => jobs(:one).id, :job => { }
    assert_redirected_to admin_job_path(assigns(:job))
  end

  def test_should_destroy_job
    login_as_admin
    assert_difference('Job.count', -1) do
      delete :destroy, :id => jobs(:one).id
    end

    assert_redirected_to admin_jobs_path
  end
end
