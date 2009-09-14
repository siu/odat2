class RemoveDependencySituationFromMedicalRecords < ActiveRecord::Migration
  def self.up
    remove_column :medical_records, :dependency_situation
  end

  def self.down
    add_column :medical_records, :dependency_situation, :integer
  end
end
