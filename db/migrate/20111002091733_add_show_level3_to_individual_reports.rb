class AddShowLevel3ToIndividualReports < ActiveRecord::Migration
  def self.up
    add_column :individual_reports, :show_level3, :boolean, :default => 0
  end

  def self.down
    remove_column :individual_reports, :show_level3
  end
end
