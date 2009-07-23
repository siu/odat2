class MoveHandicapValueFromOdatDiagnosesToMedicalRecords < ActiveRecord::Migration
  def self.up
    remove_column :odat_diagnoses, :handicap_value
    add_column :medical_records, :handicap, :boolean, :null => false, :default => false
    add_column :medical_records, :dependency_degree, :integer
    add_column :medical_records, :dependency_situation, :integer
  end

  def self.down
    add_column :odat_diagnoses, :handicap_value, :integer
    remove_column :medical_records, :handicap
    remove_column :medical_records, :dependency_degree
    remove_column :medical_records, :dependency_situation
  end
end
