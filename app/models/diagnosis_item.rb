class DiagnosisItem < ActiveRecord::Base
  acts_as_nested_set
  acts_as_html_text

  validates_presence_of :name
  validates_presence_of :description

  default_scope :order => 'id ASC'

  def self.categories
    self.find(:all, :conditions => "parent_id = 0 OR parent_id IS NULL")
  end

  def self.subcategories
    self.categories.collect{ |c| c.children }.flatten!
  end

  alias :subcategories :children
  alias :items :children

  def is_ancestor_of_any?(items)
    items != (items - self.items)
  end

end
