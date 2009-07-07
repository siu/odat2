class CreateComparativeReportTemplates < ActiveRecord::Migration
  def self.up
    create_table :comparative_report_templates do |t|
      t.string :name
      t.string :title
      t.text :view_template

      t.timestamps
    end
  end

  def self.down
    drop_table :comparative_report_templates
  end
end
