require 'test_helper'

class ReportTemplateTest < ActiveSupport::TestCase

  test "create a valid report" do
    report = create_report
    assert report.valid?
  end

  test "require name" do
    report = create_report(:name => nil)
    assert !report.valid?
  end

  test "require title" do
    report = create_report(:title => nil)
    assert !report.valid?
  end

  test "require applicable_on" do
    report = create_report(:applicable_on => nil)
    assert !report.valid?
  end

  test "applicable_on? should return true" do
    report = create_report(:applicable_on => "String")
    assert report.applicable_on?(String)
  end

protected
  def create_report(opts = {})
    report = ReportTemplate.new({
        :name => 'Centros',
        :title => 'Centros',
        :applicable_on => 'String'
      }.merge!(opts))
  end
end
