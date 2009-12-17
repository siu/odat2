class AddStateColumnsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :active,    :boolean, :null => false, :default => true
    add_column :users, :approved,  :boolean, :null => false, :default => false
    add_column :users, :confirmed, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :users, :active
    remove_column :users, :approved
    remove_column :users, :confirmed
  end
end
