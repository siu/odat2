class OdatDiagnosis < ActiveRecord::Base
  belongs_to :medical_record

  belongs_to 	:origin_source, # Fuente de derivacion
    :foreign_key => 'origin_source_id'

  belongs_to 	:origin_cause, # Motivo de derivacion
    :foreign_key => 'origin_cause_id'

  belongs_to 	:consultation_cause, 
    :foreign_key => 'consultation_cause_id'

  belongs_to 	:main_diagnosis, 
    :class_name => 'DiagnosisItem', 
    :foreign_key => 'main_diagnosis_item_id'

  has_and_belongs_to_many :diagnosis_items

  has_and_belongs_to_many :center_resources

  # Validaciones
  validates_presence_of :medical_record_id,
    :message => N_('El diagnostico debe estar asociado a un expediente')

  validates_presence_of :created_at, 
    :message => N_('Es necesario una fecha de creación')

  validates_presence_of :origin_source_id, 
    :message => N_('Debes especificar una fuente de derivación')
  validates_presence_of :origin_cause_id, 
    :message => N_('Debes especificar un motivo de derivación')
  validates_presence_of :consultation_cause_id, 
    :message => N_('Debes especificar un motivo de consulta')
  validates_presence_of :main_diagnosis_item_id, 
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
end
