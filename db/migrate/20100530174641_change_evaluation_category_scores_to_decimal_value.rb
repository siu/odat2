class ChangeEvaluationCategoryScoresToDecimalValue < ActiveRecord::Migration
  def self.up
    change_column :evaluation_category_scores, :score, :decimal
  end

  def self.down
    change_column :evaluation_category_scores, :score, :integer
  end
end
