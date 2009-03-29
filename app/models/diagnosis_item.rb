class DiagnosisItem < ActiveRecord::Base
  acts_as_nested_set
  acts_as_html_text


  validates_presence_of :name
  validates_presence_of :description

  def self.root
    self.find(1)
  end

  def self.categories
    self.find(1).direct_children
  end

  def self.subcategories
    self.categories.collect{ |c| c.direct_children }.flatten!
  end

  def subcategories
    self.direct_children
  end

  def is_parent?(item)
    (item[left_col_name] > self[left_col_name]) and 
      (item[right_col_name] < self[right_col_name])
  end

end
