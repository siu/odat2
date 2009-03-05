require 'test_helper'

class Admin::JobStatusesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:job_statuses)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_job_status
    assert_difference('JobStatus.count') do
      post :create, :job_status => { }
    end

    assert_redirected_to admin_job_status_path(assigns(:job_status))
  end

  def test_should_show_job_status
    get :show, :id => job_statuses(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => job_statuses(:one).id
    assert_response :success
  end

  def test_should_update_job_status
    put :update, :id => job_statuses(:one).id, :job_status => { }
    assert_redirected_to admin_job_status_path(assigns(:job_status))
  end

  def test_should_destroy_job_status
    assert_difference('JobStatus.count', -1) do
      delete :destroy, :id => job_statuses(:one).id
    end

    assert_redirected_to admin_job_statuses_path
  end
end
