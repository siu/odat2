class ModifyColumnsOfIndividualReports < ActiveRecord::Migration
  def self.up
    remove_column :individual_reports, :show_multiple_birth
    add_column :individual_reports, :show_coordination_services, :boolean
    add_column :individual_reports, :show_main_diagnosis, :boolean
  end

  def self.down
    add_column :individual_reports, :show_multiple_birth, :boolean
    remove_column :individual_reports, :show_coordination_services
    remove_column :individual_reports, :show_main_diagnosis
  end
end
