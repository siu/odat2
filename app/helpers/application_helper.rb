# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def vtable(collection, headers, options = {}, &proc)
    options.reverse_merge!({
      :placeholder  => _('No hay elementos.'),
      :caption      => nil,
      :summary      => nil,
      :footer       => nil
    })
    if collection.any?
      summary = options[:summary] || _('Listado de ') + collection.first.class.to_s.pluralize
      output = "<table summary=\"#{summary}\">\n"
      output << content_tag('caption', options[:caption]) if options[:caption]
      output << "\t<caption>#{options[:caption]}</caption>\n" if options[:caption]
      output << content_tag('thead', content_tag('tr', headers.collect { |h| "\n\t" + content_tag('th', h) }))
      output << "<tfoot><tr>" + content_tag('th', options[:footer], :colspan => headers.size) + "</tr></tfoot>\n" if options[:footer]
      output << "<tbody>\n"
      concat(output, proc.binding)
      collection.each do |row|
	proc.call(row, cycle('odd', 'even'))
      end
      concat("</tbody>\n</table>\n", proc.binding)
    else
      concat("<p>#{options[:placeholder]}</p>", proc.binding)
    end
  end

  def print_boolean(value)
    if value
      _('Sí')
    else
      _('No')
    end
  end

end
