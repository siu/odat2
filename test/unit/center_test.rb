require 'test_helper'

class Admin::CenterTest < ActiveSupport::TestCase
  def test_invalid_default_attributes
    center =  Center.new
    assert !center.valid?
    assert center.errors.invalid?(:name)
    assert center.errors.invalid?(:region)
  end
end
