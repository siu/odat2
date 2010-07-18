require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "locale_rtl? is true for ar language" do
    I18n.locale = :ar
    assert locale_rtl?
  end
  test "locale_rtl? is false for pt language" do
    I18n.locale = :pt
    assert !locale_rtl?
  end
end
