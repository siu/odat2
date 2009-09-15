# encoding: UTF-8
class OriginSource < ActiveRecord::Base
  acts_as_html_text

  validates_presence_of :name

  default_scope :order => 'position ASC, name ASC'
end
