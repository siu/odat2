class Region < ActiveRecord::Base
  validates_presence_of :name

  def self.per_page
    5
  end
end
