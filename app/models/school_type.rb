# encoding: UTF-8
class SchoolType < ActiveRecord::Base
  acts_as_html_text

  validates_presence_of :name
end
