require 'applicable_on'
class ReportFieldTemplate < ActiveRecord::Base
  RENDER_METHODS = %w(single_value matrix graph)
  validates_presence_of :function
  validates_inclusion_of :render_method, :in => RENDER_METHODS
  validate :render_options_is_a_hash
  before_save :marshal_render_options

  include Odat::ApplicableOn
  acts_as_applicable_on

  def render_options=(val)
    unless val.nil? || val.instance_of?(Hash)
      write_attribute(:render_options, eval(val))
    else
      write_attribute(:render_options, val)
    end
  rescue SyntaxError, NameError => exc
    write_attribute(:render_options, val)
  end

  def apply(items)
    objs = items
    eval(self.function, binding)
  end

  def after_initialize
    self.render_options = self.render_options
  rescue SyntaxError, NameError => exc
    write_attribute(:render_options, nil)
  end
protected
  def render_options_is_a_hash
    begin
      unless self.render_options.nil? || self.render_options.instance_of?(Hash)
        write_attribute(:render_options, eval(self.render_options))
      else
        write_attribute(:render_options, self.render_options)
      end
      if(render_options.nil? || render_options.instance_of?(Hash))
        true
      else
        self.errors.add(:render_options)
      end
    rescue SyntaxError, NameError => exc
      self.errors.add(:render_options, _('Error de sintaxis o de nombrado de variables: %{message}') % {:message => exc.message})
    end
  end
end
