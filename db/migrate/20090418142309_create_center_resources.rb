class CreateCenterResources < ActiveRecord::Migration
  def self.up
    create_table :center_resources do |t|
      t.string :name
      t.text :description
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :center_resources
  end
end
