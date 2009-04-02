class AddMultipleBirthToMedicalRecord < ActiveRecord::Migration
  def self.up
    add_column :medical_records, :multiple_birth, 
      :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :medical_records, :multiple_birth
  end
end
