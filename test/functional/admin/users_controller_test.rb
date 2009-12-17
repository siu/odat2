require 'test_helper'

# Re-raise errors caught by the controller.
class Admin::UsersController; def rescue_action(e) raise e end; end

class Admin::UsersControllerTest < ActionController::TestCase
  include MyApp::Admin::NotLoggedInChecks
  include MyApp::Admin::UserLoggedInChecks

  fixtures :users

  def test_should_show_index
    login_as_admin
    get :index
    assert_response :success
  end

  def test_should_show_user
    login_as_admin
    get :show, :id => users(:demo).id
    assert_response :success
  end

  def test_should_allow_signup
    login_as_admin
    assert_difference 'User.count' do
      create_user
      assert_response :redirect
    end
  end

  def test_should_require_login_on_signup
    login_as_admin
    assert_no_difference 'User.count' do
      create_user(:login => nil)
      assert assigns(:user).errors.on(:login)
      assert_response :success
    end
  end

  def test_should_require_password_on_signup
    login_as_admin
    assert_no_difference 'User.count' do
      create_user(:password => nil)
      assert assigns(:user).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    login_as_admin
    assert_no_difference 'User.count' do
      create_user(:password_confirmation => nil)
      assert assigns(:user).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    login_as_admin
    assert_no_difference 'User.count' do
      create_user(:email => nil)
      assert assigns(:user).errors.on(:email)
      assert_response :success
    end
  end
  
  def test_should_sign_up_user_in_active_state
    login_as_admin
    create_user
    assigns(:user).reload
    assert assigns(:user).active?
  end

protected
  def create_user(options = {})
    post :create, 
      :user => { 
        :login => 'quire', 
        :email => 'quire@example.com',
        :password => 'quire69', 
        :password_confirmation => 'quire69',
        :center_id => centers(:demo).id 
      }.merge(options)
  end
end
