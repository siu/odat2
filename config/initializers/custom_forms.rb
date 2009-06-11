module ActionView
  module Helpers
    module FormHelper
      def label_with_require(object_name, method, text = nil, options = {})
        text = (text.blank? ? nil : text.to_s) || method.to_s.humanize
        text << '<strong><sup>*</sup></strong>' if options[:required] 
        text = %Q{<span class="requiredField">#{text}</span>} if options[:required]
        options.delete(:required)
        @template.label_without_require(object_name, method, text, options)
      end
      alias_method_chain :label, :require
    end
  end
end

