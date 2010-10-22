# encoding: UTF-8
class ComparativeReport < Report
  set_table_name "comparative_reports"
  default_scope :order => 'comparative_reports.created_at DESC'

  has_many :item_report_associations, 
    :autosave => true, 
    :validate => false

  belongs_to :comparative_report_template
  belongs_to :center

  # Report field templates
  has_many :comparative_report_field_template_assignments,
    :dependent => :destroy,
    :autosave => true,
    :include => :report_field_template
  has_many :report_field_templates, 
    :through => :comparative_report_field_template_assignments, 
    :uniq => true

  alias :template :comparative_report_template

  def items=(elements)
    self.item_report_associations.delete_all
    elements.each do |element|
      self.item_report_associations << ItemReportAssociation.new(
        :item => element, :comparative_report => self)
    end
  end

  def items
    item_report_associations.collect { |a| a.item }
  end

  def results
    comparative_report_field_template_assignments.collect { |a| a.results }
  end

  # Helpers for views
  def show_extra_information?
    !extra_information_html.nil? && !extra_information_html.empty?
  end

  def show_report_data?
    [
      :show_extra_information?
    ].any? do |a|
      self.send(a)
    end
  end

end
