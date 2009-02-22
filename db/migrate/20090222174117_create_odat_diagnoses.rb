class CreateOdatDiagnoses < ActiveRecord::Migration
  def self.up
    create_table :odat_diagnoses do |t|
      t.integer :medical_record_id
      t.integer :derivation_source_id
      t.integer :derivation_cause_id
      t.integer :consultation_reason_id
      t.integer :handicap_value
      t.integer :main_diagnosis_item_id
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :odat_diagnoses
  end
end
