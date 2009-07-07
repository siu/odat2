class ComparativeReports < ActiveRecord::Migration
  def self.up
    create_table :comparative_reports do |t|

      t.boolean  "show_signature",                      :default => true
      t.string   "signature",            :limit => 150
      t.boolean  "show_signed_on",                      :default => true
      t.datetime "signed_on"

      t.integer  "configurable_view_id"
      t.integer  "center_id"
      t.integer  "comparative_report_template_id"

      t.string   "type", :null => false, :default => 'ComparativeReport'

      t.timestamps
    end
  end

  def self.down
    drop_table :comparative_reports
  end
end
