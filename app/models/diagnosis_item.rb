# encoding: UTF-8
class DiagnosisItem < ActiveRecord::Base
  acts_as_nested_set
  acts_as_html_text

  named_scope :level1_2_roots, :conditions => "#{parent_column_name} is NULL AND id <= 285", :order => quoted_left_column_name
  named_scope :level3_roots, :conditions => "#{parent_column_name} is NULL AND id > 285", :order => quoted_left_column_name

  validates_presence_of :name

  def is_ancestor_of_any?(items)
    items.any? { |i| i.is_or_is_descendant_of?(self) }
  end
end
