class AddMultipleSelectColumnToDiagnosisItems < ActiveRecord::Migration
  def self.up
    add_column :diagnosis_items, :multiple_select, :boolean, :default => 1
  end

  def self.down
    remove_column :diagnosis_items, :multiple_select
  end
end
