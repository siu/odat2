class ComparativeReport < Report
  has_many :comparative_report_function_assignments
  has_many :comparative_functions, 
    :through => :comparative_report_function_assignments

  has_many :item_report_associations, :dependent => :destroy

  def items
    item_report_associations.collect { |i| i.item }
  end

  def items=(items)
    self.item_report_associations = items.collect { |i| ItemReportAssociation.new_for(self,i) }
  end
end
