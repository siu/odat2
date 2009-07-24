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
    @results ||= ComparativeReportResults.new(report_field_templates, items)
  end

end

class ComparativeReportResults
  def initialize(functions, items)
    @functions = functions
    @items = items
    @results = []
  end

  def [](i)
    @results[i % @functions.size] ||= compute_results(i % @functions.size)
  end
  
  def method_missing(*args, &block)
    @results.__send__ *args, &block
  end 

  def first
    self[0]
  end

  def last
    self[-1]
  end

protected
  def compute_results(i)
    function = @functions[i]
    { :render_method => function.render_method,
      :render_options => function.render_options,
      :data => function.apply(@items)
    }
  end
end
