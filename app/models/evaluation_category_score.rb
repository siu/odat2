class EvaluationCategoryScore < ActiveRecord::Base
  belongs_to :odat_diagnosis
  belongs_to :evaluation_category
end
