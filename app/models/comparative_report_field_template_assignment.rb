# encoding: UTF-8
class ComparativeReportFieldTemplateAssignment < ActiveRecord::Base
  belongs_to :comparative_report
  belongs_to :report_field_template

  default_scope :order => 'position ASC'
end
