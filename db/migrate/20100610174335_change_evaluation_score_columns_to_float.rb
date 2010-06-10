class ChangeEvaluationScoreColumnsToFloat < ActiveRecord::Migration
  def self.up
    change_column :evaluation_category_scores, :score, :float
    change_column :evaluation_categories, :min_range, :float, :default => 1.0
    change_column :evaluation_categories, :max_range, :float, :default => 10.0
  end

  def self.down
    change_column :evaluation_category_scores, :score, :decimal
    change_column :evaluation_categories, :min_range, :integer, :default => 1
    change_column :evaluation_categories, :max_range, :integer, :default => 3
  end
end
