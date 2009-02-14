class CreateCenters < ActiveRecord::Migration
  def self.up
    create_table :centers do |t|
      t.string :name, :limit => 50, :null => false
      t.integer :region_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :centers
  end
end
