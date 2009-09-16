class AddExtraInformationColumnToReports < ActiveRecord::Migration
  def self.up
    [:individual_reports, :comparative_reports, :reports].each do |table|
        add_column table, :extra_information, :text
        add_column table, :extra_information_html, :text
    end
  end

  def self.down
    [:individual_reports, :comparative_reports, :reports].each do |table|
        remove_column table, :extra_information
        remove_column table, :extra_information_html
    end
  end
end
