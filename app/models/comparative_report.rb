class ComparativeReport < Report
  has_many :comparative_report_function_assignments
  has_many :comparative_functions, 
    :through => :comparative_report_function_assignments

  has_many :item_report_associations, :dependent => :destroy

  def items
    @items ||= item_report_associations.collect { |i| i.item }
  end

  def items=(items)
    @items = nil
    self.item_report_associations = items.collect { |i| ItemReportAssociation.new_for(self,i) }
  end

  def results
    @results ||= compute_results()
  end

protected
  def compute_results
    results = []
    for function in comparative_functions
      results << {:render_method => function.render_method,
                  :render_options => function.render_options,
                  :data => function.apply(self.items)}
    end
    results
  end
end
