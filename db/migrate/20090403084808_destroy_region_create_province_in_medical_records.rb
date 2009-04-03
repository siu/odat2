class DestroyRegionCreateProvinceInMedicalRecords < ActiveRecord::Migration
  def self.up
    remove_column :medical_records, :region_id
    add_column :medical_records, :province_id, :integer
  end

  def self.down
    remove_column :medical_records, :province_id
    add_column :medical_records, :region_id, :integer
  end
end
