class Report < ActiveRecord::Base
  validate :is_signed_if_show_signature
  validates_presence_of :signed_on
  validates_presence_of :configurable_view

  belongs_to :configurable_view, :dependent => :destroy

  def initialize(args = nil)
    super(args)
    self.build_configurable_view
  end
  
protected
  def is_signed_if_show_signature
    if show_signature? && (signature.nil? || signature.empty?)
      errors.add(:signature)
    end

  end

end
