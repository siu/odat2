class ComparativeReport < Report
  set_table_name "comparative_reports"

  has_many :comparative_report_field_template_assignments
  has_many :report_field_templates, 
    :through => :comparative_report_field_template_assignments, 
    :autosave => true, 
    :uniq => true

  has_many :item_report_associations, 
    :autosave => true, 
    :validate => false

  belongs_to :comparative_report_template
  belongs_to :center

  accepts_nested_attributes_for :comparative_report_field_template_assignments, 
    :allow_destroy => true

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
    @results ||= compute_results()
  end

protected
  def compute_results
    results = []
    for function in report_field_templates
      results << {:render_method => function.render_method,
                  :render_options => function.render_options,
                  :data => function.apply(self.items)}
    end
    results
  end
end
