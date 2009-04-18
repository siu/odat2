require 'test_helper'

class CenterResourceTest < ActiveSupport::TestCase
  test "test invalid default attributes" do
    res =  CenterResource.new
    assert !res.valid?
    assert res.errors.invalid?(:name)
    assert res.errors.invalid?(:position)
  end
end
