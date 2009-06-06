require 'applicable_on'
class ReportTemplate < ActiveRecord::Base

  include Odat::ApplicableOn
  acts_as_applicable_on

  validates_presence_of :name, :title, :applicable_on

  has_many :report_templates_report_field_templates
  has_many :report_field_templates,
    :through => :report_templates_report_field_templates,
    :order => 'position ASC'

end
