require 'test_helper'

class ConfigurableViewTest < ActiveSupport::TestCase
  test "Should have default values" do
    view = create_configurable_view
    assert !view.font_size.nil?
    assert view.font_size > 0
    assert view.font_family.nil?
    assert !view.top_margin.nil?
    assert view.top_margin > 0
  end

protected
  def create_configurable_view
    view = ConfigurableView.create
  end
end
