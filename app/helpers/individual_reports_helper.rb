# encoding: UTF-8
module IndividualReportsHelper
  def new_individual_report_path(medical_record)
    new_medical_record_individual_report_path(medical_record)
  end

  def individual_reports_path(medical_record)
    medical_record_individual_reports_path(
      :medical_record_id => medical_record.id)
  end

  def individual_report_path(individual_report)
    medical_record_individual_report_path(
      :medical_record_id => individual_report.medical_record_id,
      :id => individual_report.id)
  end

  def edit_individual_report_path(individual_report)
    edit_medical_record_individual_report_path(
      :medical_record_id => individual_report.medical_record_id,
      :id => individual_report.id)
  end
end
