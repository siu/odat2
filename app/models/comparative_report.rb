# encoding: UTF-8
class ComparativeReport < Report
  # Load subclasses
  require_dependency 'center_report'

  set_table_name "comparative_reports"
  default_scope :order => 'comparative_reports.created_at DESC'

  belongs_to :comparative_report_template
  belongs_to :center

  # Report field templates
  has_many :comparative_report_field_template_assignments,
    :dependent => :destroy,
    :include => :report_field_template
  has_many :report_field_templates, 
    :through => :comparative_report_field_template_assignments, 
    :uniq => true

  alias :template :comparative_report_template

  def items
    @items ||= []
  end

  def items=(_items)
    @items=_items
  end

  def results
    comparative_report_field_template_assignments.collect { |a| a.results(@items) }
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
