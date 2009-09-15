# encoding: UTF-8
class Province < ActiveRecord::Base
  default_scope :order => 'name ASC'
end
