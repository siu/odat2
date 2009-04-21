class Report < ActiveRecord::Base
  validates_presence_of :signature
  validates_presence_of :signed_on

  belongs_to :configurable_view
end
