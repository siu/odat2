require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "locale_rtl? is true for ar language" do
    assert locale_rtl?('ar')
  end
  test "locale_rtl? is true for ar sym language" do
    assert locale_rtl?(:ar)
  end
  test "locale_rtl? is false for pt language" do
    assert !locale_rtl?('es')
  end
end
