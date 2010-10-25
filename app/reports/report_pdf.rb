require 'prawn'
require 'prawn/format'
require 'prawn/layout'

class ReportPdf < Prawn::Document

  def initialize(report)
    super()

    @report = report

    view = @report.configurable_view
    @font_size = view.font_size ? view.font_size*0.9 : 12
    @border_style = view.table_grid? ? :grid : :underline_header

    tags :h1 => {:font_size => @font_size * 1.3333, :font_weight => :bold}
    tags :h2 => {:font_size => @font_size * 1.1666, :font_weight => :bold}
    tags :h3 => {:font_size => @font_size * 1.0833, :font_weight => :bold}
    tags :indent => {:width => '2em'}

    tags :small => {:font_size => @font_size * 0.8333}
    tags :br => {}
    tags :p => {}

    font "#{Prawn::BASEDIR}/data/fonts/DejaVuSans.ttf"
    font_size = @font_size

  end

  def to_pdf
    view
    render
  end

  def _(msg)
    return msg
  end

  def l(msg, args = {})
    return msg
  end

  def print_boolean(value)
    if value
      _('Sí')
    else
      _('No')
    end
  end

  def h1(text)
    text mytag(:h1, text)
    move_down 40-16
  end

  def h2(text)
    text mytag(:h2, text)
    move_down 30-14
    text
  end

  def h3(text)
    text mytag(:h3, text)
    move_down 30-13
  end

  def mytag(tag, text)
    "<#{tag.to_s}>" << text << "</#{tag.to_s}>"
  end

  def print_table(data)
    return if data.empty?
    table data,
      :border_style => @border_style,
      :column_widths => { 0 => 250},
      :align => :left,
      :font_size => @font_size
    move_down 30
  end

  def pdf_list(elements, options = {})
    items = elements.each do |key, value|
      if value.is_a?(Hash)
        bounding_box([bounds.left + 20, cursor], :width => bounds.width) do
          text("&bull; #{key.to_s}")
          move_down 10
          pdf_list(value, options)
        end
      else
        bounding_box([bounds.left + 20, cursor], :width => bounds.width) do
          text("&bull; #{key.to_s} - #{mytag('strong', value.to_s)}")
        end
      end
    end
    move_down 10
  end

end
