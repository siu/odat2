class AddTableGridToConfigurableViews < ActiveRecord::Migration
  def self.up
    add_column :configurable_views, :table_grid, :boolean
  end

  def self.down
    remove_column :configurable_views, :table_grid
  end
end
