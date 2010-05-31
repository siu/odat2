class CreateEvaluationCategories < ActiveRecord::Migration
  def self.up
    create_table :evaluation_categories do |t|
      t.string :name, :null => false

      t.boolean :accepts_null, :null => false, :default => true
      t.integer :default_value, :null => true, :default => nil

      t.integer :min_range, :null => true, :default => 1
      t.integer :max_range, :null => true, :default => 3

      t.timestamps
    end
  end

  def self.down
    drop_table :evaluation_categories
  end
end
