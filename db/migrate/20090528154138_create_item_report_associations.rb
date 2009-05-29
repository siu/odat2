class CreateItemReportAssociations < ActiveRecord::Migration
  def self.up
    create_table :item_report_associations do |t|
      t.string :item_type
      t.integer :item_id
      t.integer :comparative_report_id

      t.timestamps
    end
  end

  def self.down
    drop_table :item_report_associations
  end
end
