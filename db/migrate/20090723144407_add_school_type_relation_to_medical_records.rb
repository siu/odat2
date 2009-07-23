class AddSchoolTypeRelationToMedicalRecords < ActiveRecord::Migration
  def self.up
    add_column :medical_records, :school_type_id, :integer
  end

  def self.down
    remove_column :medical_records, :school_type_id
  end
end
