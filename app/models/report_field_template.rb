require 'applicable_on'
class ReportFieldTemplate < ActiveRecord::Base
  RENDER_METHODS = [:single_value, :matrix, :graph]
  validates_presence_of :function
  validate :render_options_has_correct_format
  before_save :marshal_render_options

  include Odat::ApplicableOn
  acts_as_applicable_on

  def render_options=(val)
    return if val.nil?
    if val.instance_of?(String) && !val.empty?
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
  def render_options_has_correct_format
    begin
      unless(render_options.instance_of?(Hash) && 
         render_options.has_key?(:method) && 
         RENDER_METHODS.include?(render_options[:method]))
        self.errors.add(:render_options)
      end

    rescue SyntaxError, NameError => exc
      self.errors.add(:render_options, _('Error de sintaxis o de nombrado de variables: %{message}') % {:message => exc.message})
    end
  end
end
