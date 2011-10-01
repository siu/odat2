# encoding: UTF-8
class DiagnosisItem < ActiveRecord::Base
  acts_as_nested_set
  acts_as_html_text

  validates_presence_of :name

  def is_ancestor_of_any?(items)
    items.any? { |i| i.is_or_is_descendant_of?(self) }
  end
end
