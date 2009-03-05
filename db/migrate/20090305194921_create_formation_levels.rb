class CreateFormationLevels < ActiveRecord::Migration
  def self.up
    create_table :formation_levels do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :formation_levels
  end
end
