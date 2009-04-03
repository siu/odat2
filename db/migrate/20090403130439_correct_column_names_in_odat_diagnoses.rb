class CorrectColumnNamesInOdatDiagnoses < ActiveRecord::Migration
  def self.up
    rename_column(:odat_diagnoses, :derivation_source_id, :origin_source_id)
    rename_column(:odat_diagnoses, :derivation_cause_id, :origin_cause_id)
    rename_column(:odat_diagnoses, :consultation_reason_id, :consultation_cause_id)
  end

  def self.down
    rename_column(:odat_diagnoses, :origin_source_id, :derivation_source_id)
    rename_column(:odat_diagnoses, :origin_cause_id, :derivation_cause_id)
    rename_column(:odat_diagnoses, :consultation_cause_id, :consultation_reason_id)
  end
end
