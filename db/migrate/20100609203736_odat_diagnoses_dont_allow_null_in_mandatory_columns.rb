class OdatDiagnosesDontAllowNullInMandatoryColumns < ActiveRecord::Migration
  def self.up
    change_column :odat_diagnoses, :medical_record_id, :integer, :null => false
    change_column :odat_diagnoses, :origin_source_id,  :integer, :null => false
    change_column :odat_diagnoses, :origin_cause_id,   :integer, :null => false
    change_column :odat_diagnoses, :consultation_cause_id, :integer, :null => false
    change_column :odat_diagnoses, :main_diagnosis_item_id, :integer, :null => false
  end

  def self.down
    change_column :odat_diagnoses, :medical_record_id, :integer
    change_column :odat_diagnoses, :origin_source_id,  :integer
    change_column :odat_diagnoses, :origin_cause_id,   :integer
    change_column :odat_diagnoses, :consultation_cause_id, :integer
    change_column :odat_diagnoses, :main_diagnosis_item_id, :integer
  end
end
