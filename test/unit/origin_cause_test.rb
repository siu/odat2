require 'test_helper'

class OriginCauseTest < ActiveSupport::TestCase
  test "creates valid" do
    origin_cause = create_origin_cause
    assert origin_cause.valid?
  end

  test "requires name" do
    origin_cause = create_origin_cause(:name => nil)
    assert !origin_cause.valid?
    assert origin_cause.errors.invalid?(:name)
  end
protected

  def create_origin_cause(opts = {})
    OriginCause.create({
      :name => 'Origin source'
    }.merge!(opts))
  end
end
