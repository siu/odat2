require 'test_helper'

class OriginSourceTest < ActiveSupport::TestCase
  test "creates valid" do
    origin_source = create_origin_source
    assert origin_source.valid?
  end

  test "requires name" do
    origin_source = create_origin_source(:name => nil)
    assert !origin_source.valid?
    assert origin_source.errors.invalid?(:name)
  end
protected

  def create_origin_source(opts = {})
    OriginSource.create({
      :name => 'Origin Source'
    }.merge!(opts))
  end
end
