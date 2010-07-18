class AddEvaluationCategoryScoresToIndividualReports < ActiveRecord::Migration
  def self.up
    add_column :individual_reports, :show_evaluation_scores, :boolean, :nil => false, :default => false
  end

  def self.down
    remove_column :individual_reports, :show_evaluation_scores
  end
end
