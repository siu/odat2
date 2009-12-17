require File.dirname(__FILE__) + '/../test_helper'

#class UserTest < ActiveSupport::TestCase
class UserTest < ActiveRecord::TestCase 
  fixtures :users

  def test_should_create_user
    assert_difference 'User.count' do
      user = create_user
      assert !user.new_record?, "#{user.errors.full_messages.to_sentence}"
    end
  end

  def test_should_create_and_start_in_active_state
    user = create_user
    user.reload
    assert user.active?
  end


  def test_should_require_login
    assert_no_difference 'User.count' do
      u = create_user(:login => nil)
      assert u.errors.on(:login)
    end
  end

  def test_should_require_password
    assert_no_difference 'User.count' do
      u = create_user(:password => nil)
      assert u.errors.on(:password)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference 'User.count' do
      u = create_user(:password_confirmation => nil)
      assert u.errors.on(:password_confirmation)
    end
  end

  def test_should_require_email
    assert_no_difference 'User.count' do
      u = create_user(:email => nil)
      assert u.errors.on(:email)
    end
  end
  
  def test_should_require_center
    assert_no_difference 'User.count' do
      u = create_user(:center_id => nil)
      assert u.errors.on(:center_id)
    end
  end

  test "should change password when password and password_confirmation are provided" do
    old_crypted_password = users(:demo).crypted_password
    old_password_salt = users(:demo).password_salt
    users(:demo).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_not_same users(:demo).crypted_password, old_crypted_password
    assert_not_same users(:demo).password_salt, old_password_salt
  end

  test "should not rehash password if password and password_confirmation are not provided" do
    old_crypted_password = users(:demo).crypted_password
    old_password_salt = users(:demo).password_salt
    users(:demo).email = 'demo_new_mail@odat.net'
    assert users(:demo).save
    assert_same users(:demo).crypted_password, old_crypted_password
    assert_same users(:demo).password_salt, old_password_salt
  end

  def test_should_deactivate_user
    users(:demo).deactivate!
    assert !users(:demo).active?
  end

  test "should have the same medical records that his center" do
    assert_equal users(:demo).medical_records, 
      users(:demo).center.medical_records
  end

  test "demo user is not an admin" do
    assert !users(:demo).role?(:admin)
  end

  test "admin user is an admin" do
    assert users(:admin).role?(:admin)
  end

protected
  def create_user(options = {})
    record = User.create({ 
      :login => 'odat_user', 
      :email => 'odat_user@example.com', 
      :password => 'odat_12345', 
      :password_confirmation => 'odat_12345',
      :center_id => centers(:demo).id }.merge(options))
    record
  end
end
