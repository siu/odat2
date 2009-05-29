require 'test_helper'

class ComparativeReportTest < ActiveSupport::TestCase
  test "creates valid" do
    report = create_report()
    assert report.valid?
  end

  test "Items can be added to the items list" do
    report = create_report(
      :items => [odat_diagnoses(:one), odat_diagnoses(:two)])
    assert report.valid?
  end

  test "comparative functions can be added to the functions list" do
    report = create_report(
      :comparative_functions => [comparative_functions(:one)])
    assert report.valid?, report.comparative_functions.inspect
  end

protected
  def create_report(opts = {})
    report = ComparativeReport.new({
      :signature => 'John Smith',
      :signed_on => Time.now
    }.merge!(opts))
  end
end
