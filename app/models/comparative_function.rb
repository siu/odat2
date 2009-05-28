class ComparativeFunction < ActiveRecord::Base
  RENDER_METHODS = %w(single_value matrix graph)
  validates_presence_of :function
  validates_inclusion_of :render_method, :in => RENDER_METHODS
  validate :render_options_is_a_hash
  validate :applicable_on_is_a_list_of_classes
  before_save :marshal_applicable_on
  before_save :marshal_render_options

  def applicable_on=(val)
    write_attribute(:applicable_on, eval("[" << val << "]")) unless val.nil?
  rescue SyntaxError, NameError => exc
    write_attribute(:applicable_on, val)
  end
protected
  def render_options_is_a_hash
    begin
      if(render_options.nil? || 
         render_options.instance_of?(Hash) || 
         (render_options.instance_of?(String) && 
           (  render_options.empty? || 
              eval(render_options).instance_of?(Hash))))
        true
      else
        self.errors.add(:render_options)
      end
    rescue SyntaxError, NameError => exc
      self.errors.add(:render_options, _('Error de sintaxis o de nombrado de variables: %{message}') % {:message => exc.message})
    end
  end

  def applicable_on_is_a_list_of_classes
    begin
    if((applicable_on.instance_of?(Array) && 
         is_array_of_classes?(applicable_on)) || 
       (applicable_on.instance_of?(String) && 
         eval(applicable_on).instance_of?(Array) &&
         is_array_of_classes?(eval(applicable_on))))
      true
    else
      self.errors.add(:applicable_on, _('Debe ser una lista de clases separadas por comas'))
    end
    rescue SyntaxError, NameError => exc
      self.errors.add(:applicable_on, _('Error de sintaxis o de nombrado de variables: %{message}') % {:message => exc.message})
    end
  end

  def marshal_applicable_on
    write_attribute(:applicable_on, applicable_on.to_s)
  end

  def marshal_render_options
    write_attribute(:render_options, render_options.to_s)
  end

  def is_array_of_classes?(array)
    array.all? do |element|
      element.instance_of?(Class)
    end
  end
end
