class DiagnosisItemsTextDescriptions < ActiveRecord::Migration
  def self.up
    change_table :diagnosis_items do |t|
      t.change :description, :text, :limit => nil
      t.change :description_html, :text, :limit => nil
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
