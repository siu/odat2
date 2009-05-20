require 'test_helper'

class IndividualReportTest < ActiveSupport::TestCase
  test "show_personal_data? should return true if show any personal data" do
    for a in [
      :show_full_name, 
      :show_birth_date, 
      :show_age, 
      :show_medical_record_archive_date, 
      :show_gender, 
      :show_address
    ] do
      report = create_report(a => true)
      assert report.show_personal_data?
    end
  end

  test "show_family_data? should return true if show any family data" do
    for a in [
      :show_siblings_data, 
      :show_birth_position, 
      :show_father_data, 
      :show_mother_data, 
      :show_phone_numbers
    ] do
      report = create_report(
        a => true, 
        :medical_record => medical_records(:pedrito))
      assert report.show_family_data?
    end
  end

  test "show_diagnosis_data? should return true if show any diagnosis data" do
    for a in [
      :show_diagnosis_created_at, 
      :show_consultation_details, 
      :show_center_resources, 
      :show_detailed_diagnosis, 
      :show_main_diagnosis
    ] do
      report = create_report(a => true)
      assert report.show_diagnosis_data?
    end
  end

  test "show_report_data? should return true if show any report data" do
    for a in [
      :topic, 
      :tests, 
      :results, 
      :orientation
    ] do
      report = create_report(a => 'text')
      assert report.show_report_data?
    end
      report = create_report(:show_signature => true,
                             :signature => 'Signer')
      assert report.show_report_data?
      report = create_report(:show_signed_on => true,
                             :signed_on => Time.now)
      assert report.show_report_data?
  end

  protected
  def create_report(options = {})
    report = IndividualReport.create({
      :signature => 'John Smith',
      :signed_on => Time.now }.merge(options))
    report
  end
end
