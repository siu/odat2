
class ActiveRecord::Errors
  def full_messages
    full_messages = []

    @errors.each_key do |attr| 
      @errors[attr].each do |msg|
	next if msg.nil?

	if attr == "base"
	  full_messages << msg
	else
	  # 					full_messages << @base.class.human_attribute_name(attr) + " " + msg
	  full_messages << msg
	end
      end
    end

    return full_messages
  end
end

module ActionView
  module Helpers
    module ActiveRecordHelper
      # Ayudante para mostrar el contenido del flash
      def mostrar_flash
	return if flash.empty?
	a = ''
	flash.each do |i|
	  a << "<div id=\"flash-div\" class=\"flash-#{i[0]}\" style=\"display:none\">"
	  a << '<p><strong class="alerta">Aviso:</strong> ' +  i[-1] + '</p>'
	  a << '</div>'
	end
	a
      end

      alias :show_flash :mostrar_flash

      def error_messages_for(object_name, options = {})
	options = options.symbolize_keys
	object = instance_variable_get("@#{object_name}")
	unless object.errors.empty?
	  content_tag("div",
		      content_tag(
			options[:header_tag] || "h2",
			"El #{object_name.to_s.gsub("_", " ")} no puede ser guardado."
	  ) +
	    content_tag("p", "Se encontraron los siguientes errores:") +
	    content_tag("ul", object.errors.full_messages.collect { |msg| content_tag("li", msg) }),
	    "id" => options[:id] || "errorExplanation", "class" => options[:class] || "errorExplanation"
		     )
	end
      end
    end
  end
end


class Time < Time.superclass
  # Formateo corto de una fecha y hora
  def short_format
    self.strftime("%d/%m/%Y a las %H:%M")
  end
end

class Date < Date.superclass
  # Formateo corto de una fecha
  def short_format
    self.strftime("%d/%m/%Y")
  end
end
