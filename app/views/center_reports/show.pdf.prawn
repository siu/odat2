# encoding: UTF-8
require 'prawn'
require 'prawn/format'

view = @center_report.configurable_view
@font_size = view.font_size ? view.font_size*0.8 : 12
@border_style = view.table_grid? ? :grid : :underline_header

def h1(pdf, text)
  pdf.text mytag(:h1, text)
  pdf.move_down 40-16
end

def h2(pdf, text)
  pdf.text mytag(:h2, text)
  pdf.move_down 20-14
  text
end

def h3(pdf, text)
  pdf.text mytag(:h3, text)
  pdf.move_down 20-13
end

def mytag(tag, text)
  "<#{tag.to_s}>" << text << "</#{tag.to_s}>"
end

def print_table(pdf, data)
  return if data.empty?
  pdf.table data,
    :border_style => @border_style,
    :column_widths => { 0 => 200},
    :align => :left,
    :font_size => @font_size
  pdf.move_down 20
end

def pdf_list(pdf, elements, options = {})
  items = elements.each do |key, value|
    if value.is_a?(Hash)
      pdf.bounding_box([pdf.bounds.left + 20, pdf.cursor], :width => pdf.bounds.width) do
        pdf.text("&bull; #{key.to_s}")
        pdf.move_down 10
        pdf_list(pdf, value, options)
      end
    else
      pdf.bounding_box([pdf.bounds.left + 20, pdf.cursor], :width => pdf.bounds.width) do
        pdf.text("&bull; #{key.to_s} - #{mytag("strong", value.to_s)}")
      end
    end
  end
  pdf.move_down 10
end

pdf.tags :h1 => {:font_size => @font_size * 1.3333, :font_weight => :bold}
pdf.tags :h2 => {:font_size => @font_size * 1.1666, :font_weight => :bold}
pdf.tags :h3 => {:font_size => @font_size * 1.0833, :font_weight => :bold}
pdf.tags :indent => {:width => '2em'}

pdf.tags :small => {:font_size => @font_size * 0.8333}
pdf.tags :br => {}
pdf.tags :p => {}

pdf.font "#{Prawn::BASEDIR}/data/fonts/DejaVuSans.ttf"

# Begin document
h1(pdf, @center_report.title)

@center_report.report_field_templates.each_with_index do |function, index|
  h2(pdf, function.name)

begin
  if @center_report.results[index][:render_method] == 'table'
    print_table(pdf, @center_report.results[index][:data])
  elsif @center_report.results[index][:render_method] == 'nested_list'
    pdf_list(pdf, @center_report.results[index][:data])
    #test(pdf)
  else
    pdf.text @center_report.results[index][:data].inspect
    pdf.move_down 20
  end
rescue Exception => e
  pdf.text _('Algo ha ido mal') << ': ' << simple_format(h(e.message))
end

end

if @center_report.show_report_data?
  if @center_report.show_extra_information?
    h2(pdf, _('Informe de memoria'))
    pdf.text @center_report.extra_information_html
    pdf.move_down 20
  end
end

pdf.move_down 20
if @center_report.show_signed_on? and @center_report.signed_on
  pdf.text l(@center_report.signed_on.to_date, :format => :long), :align => :right
  pdf.move_down 10
end
if @center_report.show_signature?
  pdf.text h(@center_report.signature), :align => :right
  pdf.move_down 20
end
