class TableDiagnosisItemsOdatDiagnoses < ActiveRecord::Migration
  def self.up
    create_table :diagnosis_items_odat_diagnoses, :id => false do |t|
      t.integer :diagnosis_item_id, :null => false
      t.integer :odat_diagnosis_id, :null => false
    end
  end

  def self.down
    drop_table :diagnosis_items_odat_diagnoses
  end
end
