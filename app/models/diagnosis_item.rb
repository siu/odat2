class DiagnosisItem < ActiveRecord::Base
  acts_as_nested_set
  acts_as_html_text

  validates_presence_of :name
  validate :has_description_if_leaf

  default_scope :order => 'position ASC, id ASC'

  def self.categories
    self.find(:all, :conditions => "parent_id = 0 OR parent_id IS NULL")
  end

  def self.subcategories
    self.categories.collect{ |c| c.children }.flatten!
  end

  alias :subcategories :children
  alias :items :children

  def is_ancestor_of_any?(items)
    items.any? { |i| i.is_or_is_descendant_of?(self) }
  end

protected
  def has_description_if_leaf
    if !self.new_record? and self.level >= 2 and self.description.blank?
      errors.add_to_base(_('Descripción no puede estar vacía'))
    end
  end
end
