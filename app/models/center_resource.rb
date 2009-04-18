class CenterResource < ActiveRecord::Base
  acts_as_list

  validates_presence_of :name
  validates_presence_of :position

  default_scope :order => 'position ASC, name ASC'
end
