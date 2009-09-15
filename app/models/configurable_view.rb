# encoding: UTF-8
class ConfigurableView < ActiveRecord::Base
  TOP_MARGIN = 100

  def top_margin
    return TOP_MARGIN
  end

  def initialize(args)
    super(args)
    self.font_size = 14
  end

end
