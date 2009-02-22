class OdatDiagnosis < ActiveRecord::Base
  belongs_to :medical_record

  validates_presence_of :medical_record,
    :message => N_('El diagnostico debe estar asociado a un expediente')
end
