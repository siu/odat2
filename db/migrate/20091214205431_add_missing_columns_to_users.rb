class AddMissingColumnsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :role,      :string,  :null => false, :default => 'user'
    add_column :users, :name,      :string,  :limit => 25
    add_column :users, :center_id, :integer
  end

  def self.down
    remove_column :users, :name
    remove_column :users, :center_id
    remove_column :users, :role
  end
end
