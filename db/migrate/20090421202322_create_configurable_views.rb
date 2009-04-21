class CreateConfigurableViews < ActiveRecord::Migration
  def self.up
    create_table :configurable_views do |t|
      t.integer :font_size
      t.string :font_family, :limit => 150
    end

    add_column :reports, :configurable_view_id, :integer

    remove_column :reports, :font_size
    remove_column :reports, :font_family
  end

  def self.down
    drop_table :configurable_views

    remove_column :reports, :configurable_view_id

    add_column :reports, :font_size, :integer
    add_column :reports, :font_family, :string, :limit => 150
  end
end
