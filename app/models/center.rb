# encoding: UTF-8
class Center < ActiveRecord::Base
  belongs_to :region

  default_scope :order => 'name ASC'

  validates_presence_of :name
  validates_presence_of :region

  has_many :users

  has_many :medical_records
  has_many :comparative_reports
  has_many :center_reports

  # Joins
  has_many :individual_reports, :through => :medical_records
  has_many :odat_diagnoses, :through => :medical_records
end
