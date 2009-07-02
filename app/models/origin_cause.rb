class OriginCause < ActiveRecord::Base
  acts_as_html_text

  default_scope :order => 'position ASC, name ASC'
end
