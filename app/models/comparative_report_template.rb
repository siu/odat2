class ComparativeReportTemplate < ActiveRecord::Base
  has_many :comparative_report_template_field_assignments
  has_many :report_field_templates, 
    :through => :comparative_report_template_field_assignments

  accepts_nested_attributes_for :comparative_report_template_field_assignments, :allow_destroy => true
  has_many :comparative_reports

  validates_presence_of :name
  
  def build_report
    o = self.comparative_reports.build()
    o.report_field_templates = self.report_field_templates

    o
  end

  def report_field_template_ids=(ids)
    self.write_attribute(:report_field_template_ids, ids)
    self.order_report_fields(ids)
  end

  # what about adding methods to the has_many declaration?
  # could work, sample:
  # http://blog.katipo.co.nz/?p=25
  # http://refactormycode.com/codes/357-recreating-a-list-with-acts_as_list
  
protected

  def order_report_fields(ordered_ids)
    ordered_ids.each_with_index do |id, index|
      begin
        self.comparative_report_template_field_assignments.find_by_report_field_template_id(id).position = index
      rescue
      end
    end
  end
end
