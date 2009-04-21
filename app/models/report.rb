class Report < ActiveRecord::Base
  validates_presence_of :signature
  validates_presence_of :signed_on
end
