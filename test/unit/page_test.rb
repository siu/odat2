require 'test_helper'

class PageTest < ActiveSupport::TestCase
  test "invalid if title not set" do
    assert_no_difference 'Page.count' do
      page = create_page(:title => nil)
      assert page.errors.on(:title)
    end
  end

  test "invalid if permalink not set" do
    assert_no_difference 'Page.count' do
      page = create_page(:permalink => nil)
      assert page.errors.on(:permalink)
    end
  end

  test "invalid if content not set" do
    assert_no_difference 'Page.count' do
      page = create_page(:content => nil)
      assert page.errors.on(:content)
    end
  end

protected

  def create_page(options = {})
    record = Page.new({ 
      :title => 'Test page',
      :permalink => 'testpage',
      :content => 'Content for test page',
      :sidebar_content => 'Sidebar content'
      }.merge(options))
    record.save if record.valid?
    record
  end

end
