class CreateReportTemplates < ActiveRecord::Migration
  def self.up
    create_table :report_templates do |t|
      t.string :name
      t.string :title
      t.string :applicable_on

      t.timestamps
    end
  end

  def self.down
    drop_table :report_templates
  end
end
