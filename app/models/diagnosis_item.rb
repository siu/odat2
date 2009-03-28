class DiagnosisItem < ActiveRecord::Base
  acts_as_nested_set
  acts_as_html_text


  validates_presence_of :name
  validates_presence_of :description

  def self.categories
    self.find(1).direct_children
  end
end
