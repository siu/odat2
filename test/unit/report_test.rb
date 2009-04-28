require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test "create valid report" do
    report = create_report

    assert report.valid?
  end

  test "should require a signature" do
    report = create_report(:signature => nil)

    assert !report.valid?
    assert report.errors.on(:signature)
  end

  test "should require a signed_on date" do
    report = create_report(:signed_on => nil)

    assert !report.valid?
    assert report.errors.on(:signed_on)
  end

  test "should have a configurable view properties" do
    report = create_report
    assert !report.configurable_view.nil?
  end

protected
  def create_report(options = {})
    report = Report.create({
      :signature => 'John Smith',
      :signed_on => Time.now }.merge(options))
    report
  end
end
