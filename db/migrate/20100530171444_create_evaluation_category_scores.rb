class CreateEvaluationCategoryScores < ActiveRecord::Migration
  def self.up
    create_table :evaluation_category_scores do |t|
      t.integer :score, :null => true
      t.integer :odat_diagnosis_id, :null => false
      t.integer :evaluation_category_id, :null => false
    end
  end

  def self.down
    drop_table :evaluation_category_scores
  end

end
