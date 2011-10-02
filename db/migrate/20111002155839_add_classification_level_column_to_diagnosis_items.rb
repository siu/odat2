class AddLevelColumnToDiagnosisItems < ActiveRecord::Migration
  def self.up
    add_column :diagnosis_items, :classification_level, :integer
  end

  def self.down
    remove_column :diagnosis_items, :classification_level
  end
end
