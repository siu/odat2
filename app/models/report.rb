class Report < ActiveRecord::Base
  default_scope :order => 'created_at DESC'

  validate :is_signed_if_show_signature
  validates_presence_of :signed_on
  validates_presence_of :configurable_view

  belongs_to :configurable_view, :dependent => :destroy

  accepts_nested_attributes_for :configurable_view

  before_validation_on_create :init_configurable_view

  def init_configurable_view
    self.build_configurable_view
  end
  
protected
  def is_signed_if_show_signature
    if show_signature? && (signature.nil? || signature.empty?)
      errors.add(:signature)
    end

  end

end
