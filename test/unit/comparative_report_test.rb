require 'test_helper'

class ComparativeReportTest < ActiveSupport::TestCase
  test "creates valid" do
    report = create_report()
    assert report.valid?
  end

  test "Items can be added to the items list" do
    report = create_report(
      :items => [odat_diagnoses(:one), odat_diagnoses(:two)])
    assert report.valid?, report.errors.full_messages
    assert_equal 2, report.items.size
  end

  test "comparative functions can be added to the functions list" do
    report = create_report(
      :report_field_templates => [report_field_templates(:one)])
    assert report.valid?, report.report_field_templates.inspect
    assert_equal 1, report.report_field_templates.size
  end

  test "comparative functions are applied over items" do
    report = create_report(
      :items => [odat_diagnoses(:one), odat_diagnoses(:two)],
      :report_field_templates => [report_field_templates(:for_odat_diagnoses)])
    assert report.valid?, report.errors.full_messages

    assert 2, report.results.size
    assert 2, report.results.first[:data].size

    assert report.items[0].medical_record.full_name, report.results.first[:data][1]
  end

protected
  def create_report(opts = {})
    report = ComparativeReport.create({
      :signature => 'John Smith',
      :signed_on => Time.now
    }.merge!(opts))
  end
end
