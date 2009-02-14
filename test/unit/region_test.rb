require 'test_helper'

class Admin::RegionTest < ActiveSupport::TestCase
  def test_invalid_default_attributes
    region =  Region.new
    assert !region.valid?
    assert region.errors.invalid?(:name)
  end
end
