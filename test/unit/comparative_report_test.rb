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

  test "comparative functions are applied over compatible items" do
    report = create_report(
      :items => [odat_diagnoses(:one), odat_diagnoses(:two)],
      :comparative_functions => [comparative_functions(:for_odat_diagnoses)])
    assert report.valid?, report.errors.full_messages

    assert 2, report.results.size
    assert 2, report.results.first[:data].size
  end

protected
  def create_report(opts = {})
    report = ComparativeReport.new({
      :signature => 'John Smith',
      :signed_on => Time.now
    }.merge!(opts))
  end
end
