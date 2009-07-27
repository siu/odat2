require 'test_helper'

class ReportFieldTemplateTest < ActiveSupport::TestCase
  test "creates a valid function" do
    function = create_function()
    assert function.valid?, function.errors.inspect
  end

  test "requires a list of classes to be applied on" do
    function = create_function(:applicable_on => nil)
    assert !function.valid?
    assert function.errors.on(:applicable_on)
  end

  test "requires a valid list of classes to be applied on" do
    function = create_function(:applicable_on => "String")
    assert function.valid?

    function = create_function(:applicable_on => "Array")
    assert function.valid?

    function = create_function(:applicable_on => "String, Array")
    assert function.valid?
  end

  test "requires a function" do
    function = create_function(:function => '')
    assert !function.valid?
    assert function.errors.on(:function)
  end

  test "requires a render_method" do
    function = create_function(:render_method => '')
    assert !function.valid?
    assert function.errors.on(:render_method)
  end

  test "requires a valid render_method " do
    function = create_function(:render_method => 'random')
    assert !function.valid?
    assert function.errors.on(:render_method)

    methods = %w(single_value table graph nested_list)
    for method in methods do
      function = create_function(:render_method => method)
      assert function.valid?
    end
  end

  test "requires a hash (in string form) in render_options" do

    function = create_function(:render_options => 'basdfbsadf')
    assert !function.valid?
    assert function.errors.on(:render_options)

    function = create_function(:render_options => nil)
    assert function.valid?

    function = create_function(:render_options => '')
    assert function.valid?

    function = create_function(:render_options => "{:headers => ['string','size']}")
    assert function.valid?
  end

  test "applicable_on? method" do
    function = create_function(:applicable_on => 'String')
    assert function.applicable_on?(String)
    assert !function.applicable_on?(Array)

    function = create_function(:applicable_on => 'Hash, String')
    assert function.applicable_on?(String)
    assert function.applicable_on?(Hash)
    assert !function.applicable_on?(Array)

  end

  test "apply method" do
    function = create_function(:applicable_on => 'String',
                              :function => "objs.collect {|o| [o, o.size]}")
    assert function.applicable_on?(String)

    strings = %(uno cuatro)
    for string in strings do
      assert_equal [[string, string.size]], function.apply(string)
    end
  end
protected
  def create_function(opts = {})
    function = ReportFieldTemplate.new({
      :applicable_on => 'String',
      :function => "objs.collect {|o| [o.size] }",
      :render_method => 'table'
    }.merge(opts))
  end

end
