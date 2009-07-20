class ComparativeReportTemplate < ActiveRecord::Base
  has_many :comparative_report_template_field_assignments
  has_many :report_field_templates, 
    :through => :comparative_report_template_field_assignments, 
    :autosave => true, 
    :uniq => true

  has_many :comparative_reports

  accepts_nested_attributes_for :comparative_report_template_field_assignments, 
    :allow_destroy => true

  validates_presence_of :name
  
end
