require 'test_helper'

class SchoolTypeTest < ActiveSupport::TestCase
  test "creates valid" do
    st = create_school_type
    assert st.valid?
  end

  test "requires name" do
    st =  SchoolType.new
    assert !st.valid?
    assert st.errors.invalid?(:name)
  end
private
  def create_school_type(opts = {})
    st = SchoolType.new({
      :name => 'Primary School'
    }.merge(opts))
  end
end
