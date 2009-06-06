module Odat
  module ApplicableOn
    def self.included(base)  
      base.extend(ClassMethods)  
    end  

    module ClassMethods
      def acts_as_applicable_on
        validate :applicable_on_is_a_list_of_classes
        before_save :marshal_render_options
        class_eval <<-EOC
        def applicable_on=(val)
          unless val.nil? || val.instance_of?(Array)
            write_attribute(:applicable_on, eval("[" << val << "]"))
          else 
            write_attribute(:applicable_on, [])
          end
        rescue SyntaxError, NameError => exc
          write_attribute(:applicable_on, val)
        end

        def applicable_on?(klass)
          applicable_on.include?(klass)
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

        def is_array_of_classes?(array)
          return false if array.empty?
          array.all? do |element|
            element.instance_of?(Class)
          end
        end
        EOC
      end
    end
  end
end
