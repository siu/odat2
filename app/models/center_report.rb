# encoding: UTF-8
class CenterReport < ComparativeReport
  def title
    _('Informe de Centro')
  end

  def to_pdf
    CenterReportPdf.new(self).to_pdf
  end
end
