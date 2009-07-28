# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def page_title(page_title)
    content_for(:page_title) { page_title }
  end

  def print_boolean(value)
    if value
      _('Sí')
    else
      _('No')
    end
  end

  def display_no_records_message
    "<p>#{_('No se han encontrado registros.')}</p>"
  end

  FLASH_TYPES = [:error, :warning, :success, :message, :notice]
  def display_flash(type = nil)
    html = ""
    if type.nil?
      FLASH_TYPES.each { |name| html << display_flash(name) }
    else
      return flash[type].blank? ? "" : "<div id=\"flash\" class=\"#{type}\"><p class=\"hide-flash\">#{link_to_function _("Ocultar"), 'hide_flash()'}</p><p>#{flash[type]}</p></div>"
    end
    html
  end

  def show_required_fields_explanation
    @required_field_exp ||= %Q{<div class="note">} << _('Los <span class="requiredField">campos obligatorios<strong><sup>*</sup></strong></span> se muestran con un asterisco.') << %Q{</div>}
  end

  def html_list(type, elements, options = {})
    items = elements.map do |key, value|
      if value.is_a?(Hash)
        "<li>" << key.to_s << html_list(type, value, options) << "</li>"
      else
        content_tag("li", key.to_s + ' &rarr; ' + content_tag("strong", value.to_s))
      end
    end.reverse
    content_tag(type, items, options)
  end

  def ul(*args)
    html_list("ul", *args)
  end

  def ol(*args)
    html_list("ol", *args)
  end

  def note(text, options = {})
    content_tag("div", text, {:class => 'note'}.merge(options))
  end

end
