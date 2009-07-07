class CreateComparativeReportFunctionAssignments < ActiveRecord::Migration
  def self.up
    create_table :comparative_report_function_assignments do |t|
      t.integer :position
      t.string :name
      t.string :group
      t.integer :comparative_report_id
      t.integer :comparative_function_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comparative_report_function_assignments
  end
end
