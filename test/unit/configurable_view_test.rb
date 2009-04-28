require 'test_helper'

class ConfigurableViewTest < ActiveSupport::TestCase
  test "Should have default values" do
    view = create_configurable_view
    assert !view.font_size.nil?
    assert view.font_size != 0
  end

protected
  def create_configurable_view
    view = ConfigurableView.create
  end
end
