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

  has_and_belongs_to_many :level1_2_items,
    :class_name => 'DiagnosisItem',
    :conditions => 'id <= 285'

  has_and_belongs_to_many :level3_items,
    :class_name => 'DiagnosisItem',
    :conditions => 'id > 285'

  has_and_belongs_to_many :center_resources

  has_many :individual_reports, :dependent => :destroy

  # Validaciones
  validates_presence_of :medical_record
  validates_presence_of :origin_source
  validates_presence_of :origin_cause
  validates_presence_of :consultation_cause
  validates_presence_of :main_diagnosis, 
    :message => N_('Debes especificar al menos un elemento en ' +
		   'diagnóstico detallado y un diagnóstico principal')

  def formatted_date
    if !self.created_at.nil?
    I18n.localize(self.created_at, :format => :short)
    else
      ''
    end
  end

  def clone
    o = super.dup
    o.center_resource_ids = self.center_resource_ids
    o.diagnosis_item_ids = self.diagnosis_item_ids
    o.main_diagnosis_item_id = self.main_diagnosis_item_id
    o
  end

  def main_diagnosis_items
    diagnosis_items.select do |i|
      i.level < 3
    end
  end
end
