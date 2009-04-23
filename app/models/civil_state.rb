class CivilState < ActiveRecord::Base
  validates_presence_of :name

  default_scope :order => 'position ASC, name ASC'
end
