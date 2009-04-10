class AddCenterIdColumnToUsersTable < ActiveRecord::Migration
  def self.up
    add_column :users, :center_id, :integer
  end

  def self.down
    remove_column :users, :center_id
  end
end
