# encoding: UTF-8
class Region < ActiveRecord::Base
  default_scope :order => 'name ASC'
  validates_presence_of :name

  has_many :centers

  def self.per_page
    5
  end
end
