# encoding: UTF-8
class ComparativeReportFieldTemplateAssignment < ActiveRecord::Base
  belongs_to :comparative_report
  belongs_to :report_field_template

  default_scope :order => 'position ASC'

  def results(items)
    @results ||= { 
      :title => report_field_template.name,
      :render_method => report_field_template.render_method,
      :render_options => report_field_template.render_options,
      :data => report_field_template.apply(items)
    }
  end
end
