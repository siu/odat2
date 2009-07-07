require 'test_helper'

class ComparativeReportTemplateTest < ActiveSupport::TestCase
  test "Should require a name" do
    template = create_comparative_report_template(:name => nil)

    assert !template.valid?
    assert template.errors.invalid?(:name)
  end

  test "Should accept a list of ReportFieldTemplates" do
    template = create_comparative_report_template(
      :report_field_templates => [report_field_templates(:one)])

    assert template.valid?, template.report_field_templates.inspect
    assert_equal 1, template.report_field_templates.size

  end

  test "Should clone to a ComparativeReport" do
    template = comparative_report_templates(:complex)

    report = template.build_report()
    assert report.report_field_templates.size == template.report_field_templates.size
    assert report.comparative_report_template == template
  end

protected
  def create_comparative_report_template(opts = {})
    template = ComparativeReportTemplate.create({
      :name =>  'center',
      :title => 'Center report'
    }.merge!(opts))
  end
end
