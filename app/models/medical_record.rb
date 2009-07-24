class MedicalRecord < ActiveRecord::Base

  DEPENDENCY_DEGREES = 1..4
  DEPENDENCY_SITUATIONS = 1..3

  belongs_to :center
  belongs_to :province

  has_many  :odat_diagnoses,
    :class_name => 'OdatDiagnosis',
    :dependent => :destroy, 
    :order => 'created_at DESC'

  has_many :individual_reports,
    :dependent => :delete_all, 
    :order => 'created_at DESC'

  # Related to father
  belongs_to :father_job,
    :class_name => 'Job',
    :foreign_key => 'father_job_id'

  belongs_to :father_civil_state,
    :class_name => 'CivilState', 
    :foreign_key => 'father_civil_state_id'

  belongs_to :father_job_status,
    :class_name => 'JobStatus',
    :foreign_key => 'father_job_status_id'

  belongs_to :father_formation_level,
    :class_name => 'FormationLevel',
    :foreign_key => 'father_formation_level_id'

  # Related to mother
  belongs_to :mother_job,
    :class_name => 'Job',
    :foreign_key => 'mother_job_id'

  belongs_to :mother_civil_state,
    :class_name => 'CivilState', 
    :foreign_key => 'mother_civil_state_id'

  belongs_to :mother_job_status,
    :class_name => 'JobStatus',
    :foreign_key => 'mother_job_status_id'

  belongs_to :mother_formation_level,
    :class_name => 'FormationLevel',
    :foreign_key => 'mother_formation_level_id'

  # Other
  belongs_to :school_type

  # Validations
  validate :not_repeated_name_for_same_center

  validates_presence_of :center,
    :message => N_('Debes especificar el centro al que pertenece')

  validates_presence_of :name, 
    :message => N_('Debes especificar un nombre')

  validates_presence_of :surname, 
    :message => N_('Debes especificar los apellidos')

  validates_presence_of :archive_date, 
    :message => N_('Es necesario una fecha de inicio de expediente')

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

  validates_numericality_of :position_in_siblings,
    :only_integer => true, 
    :allow_nil => true, 
    :message => N_('El lugar que ocupa entre los hermanos debe ser un número') 

  validates_inclusion_of :dependency_degree, :in => 1..4,
    :allow_nil=> true

  validates_inclusion_of :dependency_situation, :in => 1..3,
    :allow_nil => true

  # Filters
  before_save :namecase_name_and_surname

  def namecase_name_and_surname
    self.name = self.name.namecase
    self.surname = self.surname.namecase
  end

  # Other
  #
  def clone_last_or_new_odat_diagnosis
    if self.odat_diagnoses.empty?
      self.odat_diagnoses.build
    else
      self.odat_diagnoses.first.clone
    end
  end

  def full_name
    if name && surname
      @full_name ||= name + ' ' + surname
    else
      ''
    end
  end

  def age
    return (Date.today - birth_date).to_i / 365 if birth_date
    nil
  end

  def last_diagnosis
    self.odat_diagnoses.last || nil
  end

  def has_siblings_data?
    has_any_attr?([:total_siblings_amount, :birth_position])
  end

  def has_father_data?
    has_any_attr?([:father_name, :father_surname, :father_birth_date, :father_job_id, :father_civil_state_id, :father_job_status_id, :father_formation_level_id, :father_email, :father_extra_information])
  end

  def has_mother_data?
    has_any_attr?([:mother_name, :mother_surname, :mother_birth_date, :mother_job_id, :mother_civil_state_id, :mother_job_status_id, :mother_formation_level_id, :mother_email, :mother_extra_information])
  end

  def has_phone_data?
    has_any_attr?([:home_phone, :portable_phone, :work_phone])
  end

  def has_coordination_data?
    has_any_attr?([:sanitary_services, :social_services, :educative_services])
  end

  def has_handicap_data?
    has_any_attr?([:handicap, :dependency_degree, :dependency_situation])
  end

protected
  def has_any_attr?(attrs)
    attrs.any? do |m|
      !self.send(m).nil? && self.send(m) && 
      (!self.send(m).respond_to?(:empty?) || !self.send(m).empty?)
    end
  end

  def not_repeated_name_for_same_center
    if !self.class.find(:all, 
	  :conditions => 
	    ["(? is NULL OR id != ?) AND name = ? AND surname = ? AND center_id = ?", 
	    id, id, name, surname, center_id]).empty?
      errors.add_to_base(_('Ya existe un expediente para %{name}') % {:name => self.full_name})
    end
  end
end
