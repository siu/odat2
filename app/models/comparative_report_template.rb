class ComparativeReportTemplate < ActiveRecord::Base
  has_many :comparative_report_template_field_assignments
  has_many :report_field_templates, 
    :through => :comparative_report_template_field_assignments,
    :autosave => true

  has_many :comparative_reports

  validates_presence_of :name
  
  def build_report
    o = self.comparative_reports.build()
    o.report_field_templates = self.report_field_templates

    o
  end

  def report_field_template_ids=(ids)
    deleted = self.report_field_template_ids - ids
    new = ids - self.report_field_template_ids

    deleted.each do |field|
      self.comparative_report_template_field_assignments.find_by_report_field_template_id(field).destroy
    end

    new.each do |field|
      self.report_field_templates << ReportFieldTemplate.find(field).clone
    end

    self.order_report_fields(ids)
  end

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
