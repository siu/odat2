# encoding: UTF-8
class ConfigurableView < ActiveRecord::Base
  TOP_MARGIN = 150

  def top_margin
    return TOP_MARGIN
  end

  def after_initialize
    self.font_size = 14 if self.font_size.nil? or self.font_size.blank? or self.font_size < 1
  end

end
