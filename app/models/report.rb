class Report < ActiveRecord::Base
  validates_presence_of :signature
  validates_presence_of :signed_on
  validates_presence_of :configurable_view

  belongs_to :configurable_view, :dependent => :destroy

  def initialize(args)
    super(args)
    self.build_configurable_view
  end

end
