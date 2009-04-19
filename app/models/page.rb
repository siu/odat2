class Page < ActiveRecord::Base
  acts_as_html_text

  validates_presence_of :title
  validates_presence_of :permalink
  validates_presence_of :content
end
