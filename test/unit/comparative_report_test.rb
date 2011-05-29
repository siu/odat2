require 'test_helper'

class ComparativeReportTest < ActiveSupport::TestCase
  test "creates valid" do
    report = create_report()
    assert report.valid?
  end

  test "Items can be added to the items list" do
    report = create_report(
      :items => [odat_diagnoses(:one), odat_diagnoses(:two)])
    assert report.valid?, report.errors.full_messages.join(", ")
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
    assert report.valid?, report.errors.full_messages.join(", ")

    assert_equal 1, report.results.size
    assert_equal 2, report.results.first[:data].size

    assert_equal report.items[0].medical_record.full_name, report.results.first[:data][0][1]
  end

  test "show_report_data? should return true if show any report data" do
    for a in [
      :extra_information
    ] do
      report = create_report(a => 'text')
      assert report.show_report_data?
    end
  end
  
  test "doesn't duplicate report_field_template_assignments on save" do
    old_size = comparative_reports(:one).comparative_report_field_template_assignments.count
    comparative_reports(:one).save
    new_size = comparative_reports(:one).comparative_report_field_template_assignments.count

    assert_equal(old_size, new_size)
  end

  test "save report_field_template_assignments" do
    r = comparative_reports(:one)
    old_size = r.comparative_report_field_template_assignments.count
    assert(old_size > 0)

    r.report_field_template_ids = []
    r.save

    new_size = r.comparative_report_field_template_assignments.count

    assert_equal(0, new_size)
  end

  test "adding report_field_template_ids" do
    r = comparative_reports(:one)
    old_size = r.comparative_report_field_template_assignments.count

    r.report_field_template_ids = r.report_field_template_ids << report_field_templates(:for_medical_records3).id
    r.save

    new_size = r.comparative_report_field_template_assignments.count

    assert_equal(old_size+1, new_size)
  end

  test "removing report_field_template_ids" do
    r = comparative_reports(:one)
    old_size = r.comparative_report_field_template_assignments.count

    r.report_field_template_ids = r.report_field_template_ids[0..-2]
    r.save

    new_size = r.comparative_report_field_template_assignments.count

    assert_equal(old_size-1, new_size)
  end

protected
  def create_report(opts = {})
    report = ComparativeReport.create({
      :signature => 'John Smith',
      :signed_on => Time.now
    }.merge!(opts))
  end
end
