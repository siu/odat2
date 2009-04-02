ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'mocha'

class Test::Unit::TestCase
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

end

module NotLoggedInChecks
  #should "redirect to login if not logged in" do
  def test_redirect_to_login_if_not_logged_in
    [:index, :new, :edit, :show].each do |m|
      get m
      assert_redirected_to login_path
    end
    [:create].each do |m|
      post m
      assert_redirected_to login_path
    end
    [:update].each do |m|
      put m
      assert_redirected_to login_path
    end
    [:destroy].each do |m|
      delete m
      assert_redirected_to login_path
    end
  end
end

module MyApp
module Admin
  module NotLoggedInChecks
    #should "redirect to login if not logged in" do
    def test_redirect_to_login_if_not_logged_in
      [:index, :new, :edit, :show].each do |m|
	get m
	assert_response 404
      end
      [:create].each do |m|
	post m
	assert_response 404
      end
      [:update].each do |m|
	put m
	assert_response 404
      end
      [:destroy].each do |m|
	delete m
	assert_response 404
      end
    end
  end

  module UserLoggedInChecks
    #should "redirect to login if not logged in" do
    def test_redirect_to_login_if_not_logged_in
      login_as_user
      [:index, :new, :edit, :show].each do |m|
	get m
	assert_response 404
      end
      [:create].each do |m|
	post m
	assert_response 404
      end
      [:update].each do |m|
	put m
	assert_response 404
      end
      [:destroy].each do |m|
	delete m
	assert_response 404
      end
    end
  end
end
end
