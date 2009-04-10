ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'mocha'

class ActiveSupport::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include AuthenticatedTestHelper

  def login_as_user
    login_as :quentin
  end

  def login_as_admin
    login_as :admin
  end

  def current_user
    @current_user ||= User.find_by_id((@request.session[:user_id]))
  end

end

module NotLoggedInChecks
  def test_index_redirects_to_login_if_not_logged_in
    get :index
    assert_redirected_to login_url
  end

  def test_new_redirects_to_login_if_not_logged_in
    get :new
    assert_redirected_to login_url
  end

  def test_edit_redirects_to_login_if_not_logged_in
    get :edit
    assert_redirected_to login_url
  end

  def test_show_redirects_to_login_if_not_logged_in
    get :show
    assert_redirected_to login_url
  end

  def test_create_redirects_to_login_if_not_logged_in
    post :create
    assert_redirected_to login_url
  end

  def test_update_redirects_to_login_if_not_logged_in
    put :update
    assert_redirected_to login_url
  end

  def test_destroy_redirects_to_login_if_not_logged_in
    delete :destroy
    assert_redirected_to login_url
  end
end

module MyApp
  module Admin
    module NotLoggedInChecks
      def test_index_returns_404_if_not_logged_in
	get :index
	assert_response :not_found
      end

      def test_new_returns_404_if_not_logged_in
	get :new
	assert_response :not_found
      end

      def test_edit_returns_404_if_not_logged_in
	get :edit
	assert_response :not_found
      end

      def test_show_returns_404_if_not_logged_in
	get :show
	assert_response :not_found
      end

      def test_create_returns_404_if_not_logged_in
	post :create
	assert_response :not_found
      end

      def test_update_returns_404_if_not_logged_in
	put :update
	assert_response :not_found
      end

      def test_destroy_returns_404_if_not_logged_in
	delete :destroy
	assert_response :not_found
      end

    end

    module UserLoggedInChecks
      def test_index_returns_404_if_user_logged_in
	login_as_user
	get :index
	assert_response :not_found
      end

      def test_new_returns_404_if_user_logged_in
	login_as_user
	get :new
	assert_response :not_found
      end

      def test_edit_returns_404_if_user_logged_in
	login_as_user
	get :edit
	assert_response :not_found
      end

      def test_show_returns_404_if_user_logged_in
	login_as_user
	get :show
	assert_response :not_found
      end

      def test_create_returns_404_if_user_logged_in
	login_as_user
	post :create
	assert_response :not_found
      end

      def test_update_returns_404_if_user_logged_in
	login_as_user
	put :update
	assert_response :not_found
      end

      def test_destroy_returns_404_if_user_logged_in
	login_as_user
	delete :destroy
	assert_response :not_found
      end
    end
  end
end
