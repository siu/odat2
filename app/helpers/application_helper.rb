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

end
