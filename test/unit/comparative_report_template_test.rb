require 'test_helper'

class ComparativeReportTemplateTest < ActiveSupport::TestCase
  test "Should require a name" do
    template = create_comparative_report_template(:name => nil)

    assert !template.valid?
    assert template.errors.invalid?(:name)
  end

  test "Should accept a list of comparative report field template \
        assignment attributes" do
    template = create_comparative_report_template(
      :comparative_report_template_field_assignments_attributes => 
        [
          {:report_field_template_id => report_field_templates(:one).id}
        ])

    assert template.valid?, template.report_field_templates.inspect
    assert_equal 1, template.report_field_templates.size

  end

protected
  def create_comparative_report_template(opts = {})
    template = ComparativeReportTemplate.create({
      :name =>  'center',
      :title => 'Center report'
    }.merge!(opts))
  end
end
