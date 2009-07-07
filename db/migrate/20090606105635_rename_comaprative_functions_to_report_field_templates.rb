class RenameComaprativeFunctionsToReportFieldTemplates < ActiveRecord::Migration
  def self.up
    rename_table :comparative_functions, :report_field_templates
    rename_table :comparative_report_function_assignments,
                 :comparative_report_field_template_assignments
    rename_column  :comparative_report_field_template_assignments, 
                   :comparative_function_id,
                   :report_field_template_id
  end

  def self.down
    rename_table :report_field_templates, :comparative_functions
    rename_table :comparative_report_field_template_assignments,
                 :comparative_report_function_assignments
    rename_column  :comparative_report_function_assignments, 
                   :report_field_template_id,
                   :comparative_function_id
  end
end
