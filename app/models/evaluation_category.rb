class EvaluationCategory < ActiveRecord::Base
  has_many :evaluation_category_scores, :dependent => :destroy
  has_many :odat_diagnoses, 
    :through => :evaluation_category_scores, 
    :autosave => true,
    :uniq => :true

  def accepts_score?(val)
    return accepts_null? if val.nil?
    return (val >= min_range && val <= max_range) unless (min_range.nil? || max_range.nil?)
    return false
  end
end
