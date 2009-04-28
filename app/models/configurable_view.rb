class ConfigurableView < ActiveRecord::Base
  def initialize(args)
    super(args)
    self.font_size = 14
  end
end
