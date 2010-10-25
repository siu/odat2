# encoding: UTF-8
class CenterReportPdf < ReportPdf
  def view
    # Begin document
    h1(@report.title)

    @report.results.each do |result|
      h2(result[:title])

      begin
        if result[:render_method] == 'table'
          print_table(result[:data])
        elsif result[:render_method] == 'nested_list'
          pdf_list(result[:data])
        else
          text result[:data].inspect
          move_down 30
        end
      rescue Exception => e
        text _('Algo ha ido mal') << ': ' << h(e.message)
      end

    end

    if @report.show_report_data?
      if @report.show_extra_information?
        h2(_('Informe de memoria'))
        text @report.extra_information_html
        move_down 30
      end
    end

    move_down 30
    if @report.show_signed_on? and @report.signed_on
      text l(@report.signed_on.to_date, :format => :long), :align => :right
      move_down 10
    end
    if @report.show_signature?
      text h(@report.signature), :align => :right
      move_down 30
    end
  end
end
