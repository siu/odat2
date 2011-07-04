class RemovePositionColumnFromDiagnosisItems < ActiveRecord::Migration
  def self.up
    remove_column :diagnosis_items, :position
    remove_index :diagnosis_items, :index_diagnosis_items_on_parent_id_and_lft_and_position
  end

  def self.down
    add_column :diagnosis_items, :position, :integer
  end
end
