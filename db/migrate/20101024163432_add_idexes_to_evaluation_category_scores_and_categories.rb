class AddIdexesToEvaluationCategoryScoresAndCategories < ActiveRecord::Migration
  def self.up
    add_index :diagnosis_items, [:lft, :rgt]
    add_index :evaluation_category_scores, :odat_diagnosis_id
  end

  def self.down
    remove_index :diagnosis_items, [:lft, :rgt]
    remove_index :evaluation_category_scores, :odat_diagnosis_id
  end
end
