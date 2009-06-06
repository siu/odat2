class ComparativeReportFieldTemplateAssignment < ActiveRecord::Base
  belongs_to :comparative_report
  belongs_to :report_field_template
end
