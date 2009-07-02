class CenterResource < ActiveRecord::Base
  acts_as_list
  acts_as_html_text

  validates_presence_of :name
  validates_presence_of :position

  default_scope :order => 'position ASC, name ASC'
end
