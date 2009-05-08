class AddShowColumnsToIndividualReportsTable < ActiveRecord::Migration
  def self.up
    add_column :individual_reports, :show_medical_record_archive_date, :boolean
    add_column :individual_reports, :show_birth_date, :boolean
    add_column :individual_reports, :show_age, :boolean
    add_column :individual_reports, :show_full_name, :boolean
    add_column :individual_reports, :show_gender, :boolean
    add_column :individual_reports, :show_birth_position, :boolean
    add_column :individual_reports, :show_multiple_birth, :boolean
    add_column :individual_reports, :show_address, :boolean
    add_column :individual_reports, :show_siblings_data, :boolean
    add_column :individual_reports, :show_father_data, :boolean
    add_column :individual_reports, :show_mother_data, :boolean
    add_column :individual_reports, :show_phone_numbers, :boolean
    add_column :individual_reports, :show_diagnosis_created_at, :boolean
    add_column :individual_reports, :show_consultation_details, :boolean
    add_column :individual_reports, :show_center_resources, :boolean
    add_column :individual_reports, :show_detailed_diagnosis, :boolean
  end

  def self.down
    remove_column :individual_reports, :show_medical_record_archive_date
    remove_column :individual_reports, :show_birth_date
    remove_column :individual_reports, :show_age
    remove_column :individual_reports, :show_full_name
    remove_column :individual_reports, :show_gender
    remove_column :individual_reports, :show_birth_position
    remove_column :individual_reports, :show_multiple_birth
    remove_column :individual_reports, :show_address
    remove_column :individual_reports, :show_siblings_data
    remove_column :individual_reports, :show_father_data
    remove_column :individual_reports, :show_mother_data
    remove_column :individual_reports, :show_phone_numbers
    remove_column :individual_reports, :show_diagnosis_created_at
    remove_column :individual_reports, :show_consultation_details
    remove_column :individual_reports, :show_center_resources
    remove_column :individual_reports, :show_detailed_diagnosis
  end
end
