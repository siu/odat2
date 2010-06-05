class DbIndexes < ActiveRecord::Migration
  def self.up
    add_index :pages, :permalink
    add_index :centers, :name
    #add_index :medical_records, :center_id, :updated_at, :surname
    add_index :odat_diagnoses, :medical_record_id
    add_index :individual_reports, :medical_record_id
    add_index :comparative_reports, :center_id
    add_index :diagnosis_items, [:parent_id, :lft]
    add_index :diagnosis_items, [:parent_id, :lft, :position]
  end

  def self.down
    remove_index :pages, :permalink
    remove_index :centers, :name
    #remove_index :medical_records, :center_id, :updated_at, :surname
    remove_index :odat_diagnoses, :medical_record_id
    remove_index :individual_reports, :medical_record_id
    remove_index :comparative_reports, :center_id
    remove_index :diagnosis_items, [:parent_id, :lft]
    remove_index :diagnosis_items, [:parent_id, :lft, :position]
  end
end
