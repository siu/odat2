class AddPositionInSiblingsToMedicalRecords < ActiveRecord::Migration
  def self.up
    add_column :medical_records, :position_in_siblings, :integer
  end

  def self.down
    remove_column :medical_records, :position_in_siblings
  end
end
