class DiagnosisItem < ActiveRecord::Base
  acts_as_nested_set
  acts_as_html_text

  validates_presence_of :name
  validates_presence_of :description

  def self.categories
    self.find(:all, :conditions => "parent_id = 0 OR parent_id IS NULL", 
	      :order => "lft")
  end

  def self.subcategories
    self.categories.collect{ |c| c.direct_children }.flatten!
  end

  alias :subcategories :direct_children
  alias :items :direct_children

  def is_parent?(item)
    (item[left_col_name] > self[left_col_name]) and 
      (item[right_col_name] < self[right_col_name])
  end

  def ancestors
    self_and_ancestors - [self]
  end

  def self_and_ancestors
    self.class.find(:all, { 
      :conditions => "(#{self[left_col_name]} " +
	"BETWEEN #{left_col_name} AND #{right_col_name})", 
      :order => "#{left_col_name}" })
  end

end
