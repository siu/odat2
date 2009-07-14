class ComparativeReportTemplate < ActiveRecord::Base
  has_many :comparative_report_template_field_assignments
  has_many :report_field_templates, 
    :through => :comparative_report_template_field_assignments, :autosave => true, :uniq => true

  accepts_nested_attributes_for :comparative_report_template_field_assignments, :allow_destroy => true
  has_many :comparative_reports

  validates_presence_of :name
  
  def build_report
    o = self.comparative_reports.build()
    o.report_field_templates = self.report_field_templates

    o
  end

end
