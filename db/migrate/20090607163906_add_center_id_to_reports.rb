class AddCenterIdToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :center_id, :integer
  end

  def self.down
    remove_column :reports, :center_id
  end
end
