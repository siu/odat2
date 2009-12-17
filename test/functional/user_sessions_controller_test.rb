require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase

  test "regular user logs in" do
    post :create, :user_session => {:login => 'demo', :password => 'demodemo'}
    assert_user_logged_in
  end

  test "regular user failed log in" do
    post :create, :user_session => {:login => 'demo', :password => 'wrong'}
    assert_user_not_logged_in
  end

  test "failed log in (wrond username and password)" do
    post :create, :user_session => {:login => 'this_user_doesnt_exist', :password => 'wrong'}
    assert_user_not_logged_in
  end

  test "not active user failed log in" do
    post :create, :user_session => {:login => 'not_active_user', :password => 'demodemo'}
    assert_user_not_logged_in
  end

  test "not approved user failed log in" do
    post :create, :user_session => {:login => 'not_approved_user', :password => 'demodemo'}
    assert_user_not_logged_in
  end

  test "not confirmed user should be able to log in" do
    post :create, :user_session => {:login => 'not_confirmed_user', :password => 'demodemo'}
    assert_user_logged_in
  end

  test "admin user failed log in" do
    post :create, :user_session => {:login => 'admin', :password => 'wrong'}
    assert_user_not_logged_in
  end

  test "admin user logs in" do
    post :create, :user_session => {:login => 'admin', :password => 'secret'}
    assert_user_logged_in
  end

private
  def assert_user_logged_in
    assert_response :redirect
    assert_redirected_to root_url
  end

  def assert_user_not_logged_in
    assert_response :success
    assert_template 'new'
    assert_not_nil assigns(:user_session) 
    assert !assigns(:user_session).errors.include?(:login)
    assert !assigns(:user_session).errors.include?(:password)
  end

end
