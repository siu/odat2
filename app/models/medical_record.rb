class MedicalRecord < ActiveRecord::Base
  belongs_to :center
  delegate :region, :region=, :to => :center

  #has_many  :odat_diagnostics,
    #:class_name => 'OdatDiagnostic',
    #:dependent => :destroy, 
    #:order => 'created_at DESC'

  #has_many :individual_reports,
    #:class_name => 'IndividualReport', 
    #:dependent => :destroy, 
    #:order => 'created_at DESC'

  # Related to father
  #belongs_to :father_job,
    #:class_name => 'Job',
    #:foreign_key => 'father_job_id'

  #belongs_to :father_civil_state,
    #:class_name => 'CivilState', 
    #:foreign_key => 'father_civil_state_id'

  #belongs_to :father_job_situation,
    #:class_name => 'JobSituation',
    #:foreign_key => 'father_job_situation_id'

  #belongs_to :father_formation_level,
    #:class_name => 'FormationLevel',
    #:foreign_key => 'father_formation_level_id'

  # Related to mather
  #belongs_to :mather_job,
    #:class_name => 'Job',
    #:foreign_key => 'mather_job_id'

  #belongs_to :mather_civil_state,
    #:class_name => 'CivilState', 
    #:foreign_key => 'mather_civil_state_id'

  #belongs_to :mather_job_situation,
    #:class_name => 'JobSituation',
    #:foreign_key => 'mather_job_situation_id'

  #belongs_to :mather_formation_level,
    #:class_name => 'FormationLevel',
    #:foreign_key => 'mather_formation_level_id'

  # Validations
  validates_presence_of :center,
    :message => N_('Debes especificar el centro al que pertenece')

  validates_presence_of :name, 
    :message => N_('Debes especificar un nombre')

  validates_presence_of :surname, 
    :message => N_('Debes especificar los apellidos')

  validates_presence_of :created_at, 
    :message => N_('Es necesario una fecha de creación')

  validates_numericality_of :postal, 
    :only_integer => true, 
    :allow_nil => true, 
    :message => N_('El código postal debe ser un número'),
    :if => Proc.new { |p| p.postal != '' }

  validates_length_of :postal, 
    :is => 5, 
    :message => N_('El código postal debe tener 5 digitos'),
    :allow_blank => true

  validates_numericality_of :birth_position,
    :only_integer => true, 
    :allow_nil => true, 
    :message => N_('El número de parto debe ser un número') 

  def full_name
    surname + ', ' + name
  end

end