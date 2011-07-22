class IncreaseFieldSizeOfDiagnosisItemsDescription < ActiveRecord::Migration
  def self.up
    change_table :diagnosis_items do |t|
      t.change :description, :text, :limit => 4096
      t.change :description_html, :text, :limit => 4096
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
