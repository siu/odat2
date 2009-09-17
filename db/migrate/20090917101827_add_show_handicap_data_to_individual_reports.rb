class AddShowHandicapDataToIndividualReports < ActiveRecord::Migration
  def self.up
    add_column :individual_reports, :show_handicap_data, :boolean
  end

  def self.down
    remove_column :individual_reports, :show_handicap_data
  end
end
