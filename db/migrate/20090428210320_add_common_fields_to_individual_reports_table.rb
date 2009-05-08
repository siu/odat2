class AddCommonFieldsToIndividualReportsTable < ActiveRecord::Migration
  def self.up
    add_column :individual_reports, :signature, :string, :limit => 150
    add_column :individual_reports, :signed_on, :datetime
    add_column :individual_reports, :show_signature, :boolean, :default => true
    add_column :individual_reports, :show_signed_on, :boolean, :default => true
    add_column :individual_reports, :configurable_view_id, :integer
  end

  def self.down
    remove_column :individual_reports, :signature
    remove_column :individual_reports, :signed_on
    remove_column :individual_reports, :show_signature
    remove_column :individual_reports, :show_signed_on
    remove_column :individual_reports, :configurable_view_id
  end
end
