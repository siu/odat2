class ModifyReportsSignature < ActiveRecord::Migration
  def self.up
    [:individual_reports, :comparative_reports, :reports].each do |table|
      change_column table, :signature, :text
    end
  end

  def self.down
    [:individual_reports, :comparative_reports, :reports].each do |table|
      change_column table, :signature, :string, :limit => 150
    end
  end
end
