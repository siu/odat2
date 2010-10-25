class RemoveItemReportAssociations < ActiveRecord::Migration
  def self.up
    drop_table :item_report_associations
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
