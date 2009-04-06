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

  FLASH_TYPES = [:error, :warning, :success, :message]
  def display_flash(type = nil)
    html = ""
    if type.nil?
      FLASH_TYPES.each { |name| html << display_flash(name) }
    else
      return flash[type].blank? ? "" : "<div class="#{type}"><p>#{flash[type]}</p></div>"
    end
    html
  end
end
