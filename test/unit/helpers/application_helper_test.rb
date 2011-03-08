require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "locale_rtl? is false for default language" do
    assert !locale_rtl?
  end
  test "locale_rtl? is true for ar language" do
    FastGettext.set_locale :ar
    assert locale_rtl?
  end
  test "locale_rtl? is false for pt language" do
    FastGettext.set_locale "pt"
    assert !locale_rtl?
  end
  test "locale_rtl? is false for es language" do
    FastGettext.set_locale "es"
    assert !locale_rtl?
  end
end
