class Job < ActiveRecord::Base
  default_scope :order => 'name ASC'
  validates_presence_of :name
end
