class CivilState < ActiveRecord::Base
  # In rails 2.2 it is possible to use:
  #default_scope :order => 'name ASC'

  validates_presence_of :name
end
