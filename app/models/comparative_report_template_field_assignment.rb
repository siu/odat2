# encoding: UTF-8
class ComparativeReportTemplateFieldAssignment < ActiveRecord::Base
  belongs_to :comparative_report_template
  belongs_to :report_field_template

  default_scope :order => 'position ASC'
end
