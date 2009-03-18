class CreateOriginCauses < ActiveRecord::Migration
  def self.up
    create_table :origin_causes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :origin_causes
  end
end
