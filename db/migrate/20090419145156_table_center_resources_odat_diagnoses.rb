class TableCenterResourcesOdatDiagnoses < ActiveRecord::Migration
  def self.up
    create_table :center_resources_odat_diagnoses, :id => false do |t|
      t.integer :odat_diagnosis_id, :null => false
      t.integer :center_resource_id, :null => false
    end
  end

  def self.down
    drop_table :center_resources_odat_diagnoses
  end
end
