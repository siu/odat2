class CreateComparativeReportTemplateFieldTemplateAssignments < ActiveRecord::Migration
  def self.up
    create_table :comparative_report_template_field_assignments do |t|
      t.integer  "position"
      t.string   "name"
      t.string   "group"
      t.integer  "comparative_report_template_id"
      t.integer  "report_field_template_id"

      t.datetime "created_at"
      t.datetime "updated_at"

      t.timestamps
    end
  end

  def self.down
    drop_table :comparative_report_template_field_assignments
  end
end
