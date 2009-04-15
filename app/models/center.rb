class Center < ActiveRecord::Base
  belongs_to :region

  validates_presence_of :name
  validates_presence_of :region

  has_many :medical_records
end
