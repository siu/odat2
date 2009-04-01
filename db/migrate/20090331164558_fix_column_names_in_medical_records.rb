class FixColumnNamesInMedicalRecords < ActiveRecord::Migration
  def self.up
    rename_column :medical_records, 
      :father_job_situation_id, 
      :father_job_status_id
    rename_column :medical_records, 
      :father_study_level_id, 
      :father_formation_level_id
    rename_column :medical_records, 
      :mother_job_situation_id, 
      :mother_job_status_id
    rename_column :medical_records, 
      :mother_study_level_id, 
      :mother_formation_level_id
    rename_column :medical_records, 
      :job_phone, 
      :work_phone
  end

  def self.down
    rename_column :medical_records, 
      :father_job_status_id,
      :father_job_situation_id
    rename_column :medical_records, 
      :father_formation_level_id,
      :father_study_level_id
    rename_column :medical_records, 
      :mother_job_status_id,
      :mother_job_situation_id
    rename_column :medical_records, 
      :mother_formation_level_id,
      :mother_study_level_id
    rename_column :medical_records, 
      :work_phone,
      :job_phone
  end
end
