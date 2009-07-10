class ComparativeReport < Report
  set_table_name "comparative_reports"

  has_many :comparative_report_field_template_assignments
  has_many :report_field_templates, 
    :through => :comparative_report_field_template_assignments

  has_many :item_report_associations, :autosave => true, :validate => false, :order => 'position ASC'
  has_many :items, :through => :item_report_associations, :source_type => 'OdatDiagnosis', :validate => false

  belongs_to :comparative_report_template
  belongs_to :center

  def results
    @results ||= compute_results()
  end

protected
  def compute_results
    results = []
    for function in report_field_templates
      results << {:render_method => function.render_method,
                  :render_options => function.render_options,
                  :data => function.apply(self.items)}
    end
    results
  end
end
