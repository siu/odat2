# encoding: UTF-8
class OdatDiagnosis < ActiveRecord::Base
  acts_as_html_text

  belongs_to :medical_record

  # Fuente de derivacion
  belongs_to :origin_source

  # Motivo de derivacion
  belongs_to :origin_cause

  belongs_to :consultation_cause 

  belongs_to :main_diagnosis, 
    :class_name => 'DiagnosisItem', 
    :foreign_key => 'main_diagnosis_item_id'

  has_and_belongs_to_many :diagnosis_items

  has_and_belongs_to_many :center_resources

  has_many :individual_reports, :dependent => :destroy

  # Evaluation categories
  has_many :evaluation_category_scores,
    :dependent => :destroy, 
    :autosave => true, 
    :include  => :evaluation_category
  has_many :evaluation_categories, :through => :evaluation_category_scores, :uniq => true
  accepts_nested_attributes_for :evaluation_category_scores

  # Validaciones
  validates_presence_of :medical_record
  validates_presence_of :origin_source
  validates_presence_of :origin_cause
  validates_presence_of :consultation_cause
  validates_presence_of :main_diagnosis, 
    :message => N_('Debes especificar al menos un elemento en ' +
		   'diagnóstico detallado y un diagnóstico principal')

  def after_initialize
    EvaluationCategory.find_each do |ec|
      score = evaluation_category_scores.select {|sc| sc.evaluation_category_id == ec.id }
      evaluation_category_scores.build(:evaluation_category_id => ec.id, :score  => ec.default_value) if score.nil? or score.empty?
    end
  end

  def formatted_date
    if !self.created_at.nil?
    I18n.localize(self.created_at, :format => :short)
    else
      ''
    end
  end

  def clone
    o = super
    o.center_resource_ids = self.center_resource_ids
    o.diagnosis_item_ids = self.diagnosis_item_ids
    o.evaluation_category_scores = self.evaluation_category_scores.clone
    o
  end

  def evaluation_category_scores_attributes=(attrs)
    evaluation_category_scores.destroy_all
    attrs.each do |k, score_attrs|
      evaluation_category_scores.build(
        :evaluation_category_id => score_attrs[:evaluation_category_id],
        :score => score_attrs[:score])
    end
  end

  def get_evaluation_category_score(cat_id)
   if sc = evaluation_category_scores.find_by_evaluation_category_id(cat_id)
     sc.score
   else
     EvaluationCategory.find(cat_id).default_value
   end
  end

  def total_score
    EvaluationCategory.all.inject(0.0) do |r, s|
      if not get_evaluation_category_score(s).nil?
        r = r + get_evaluation_category_score(s)
      end
    end
  end

end
