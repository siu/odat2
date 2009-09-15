# encoding: UTF-8
class CivilState < ActiveRecord::Base
  validates_presence_of :name
  acts_as_html_text

  default_scope :order => 'position ASC, name ASC'
end
