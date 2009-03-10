class OdatDiagnosis < ActiveRecord::Base
  belongs_to :medical_record

  #belongs_to 	:fuente_derivacion, 
    #:class_name => 'FuenteDerivacion', 
    #:foreign_key => 'fuente_derivacion_id'

  #belongs_to 	:motivo_derivacion, 
    #:class_name => 'MotivoDerivacion', 
    #:foreign_key => 'motivo_derivacion_id'

  #belongs_to 	:motivo_consulta, 
    #:class_name => 'MotivoConsulta', 
    #:foreign_key => 'motivo_id'

  #belongs_to 	:diagnostico_principal, 
    #:class_name => 'ItemDiagnostico', 
    #:foreign_key => 'diagnostico_principal_id'

  #has_and_belongs_to_many :items_diagnostico, 
    #:class_name => 'ItemDiagnostico', 
    #:order => 'id ASC'

  #has_and_belongs_to_many :items_centro, 
    #:class_name => 'ItemCentro', 
    #:order => 'id ASC'

  # Validaciones
  validates_presence_of :medical_record,
    :message => N_('El diagnostico debe estar asociado a un expediente')

  validates_presence_of :created_at, 
    :message => N_('Es necesario una fecha de creación')

  #validates_presence_of :fuente_derivacion_id, 
    #:message => N_('Debes especificar una fuente de derivación')
  #validates_presence_of :motivo_derivacion_id, 
    #:message => N_('Debes especificar un motivo de derivación')
  #validates_presence_of :motivo_consulta_id, 
    #:message => N_('Debes especificar un motivo de consulta')
  #validates_presence_of :diagnostico_principal_id, 
    #:message => N_('Debes especificar al menos un elemento en ' +
		   #'diagnóstico detallado y un diagnóstico principal')

end
