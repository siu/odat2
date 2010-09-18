# encoding: UTF-8
class MedicalRecord < ActiveRecord::Base
  default_scope :order => 'surname ASC'

  DEPENDENCY_DEGREES = 1..3

  belongs_to :center
  belongs_to :province

  has_many  :odat_diagnoses,
    :class_name => 'OdatDiagnosis',
    :dependent => :destroy, 
    :order => 'created_at DESC' do
    def clone_last_or_new
      if empty?
        build
      else
        first.clone
      end
    end
  end

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

  validates_presence_of :center

  validates_presence_of :name

  validates_presence_of :surname

  validates_presence_of :archive_date

  validates_numericality_of :postal, 
    :only_integer => true, 
    :allow_nil => true, 
    :if => Proc.new { |p| p.postal != '' }

  validates_length_of :postal, 
    :is => 5, 
    :allow_blank => true

  validates_numericality_of :birth_position,
    :only_integer => true, 
    :allow_nil => true

  validates_numericality_of :position_in_siblings,
    :only_integer => true, 
    :allow_nil => true

  validates_inclusion_of :dependency_degree, :in => DEPENDENCY_DEGREES,
    :allow_nil=> true

  # Filters
  before_save :namecase_name_and_surname

  def namecase_name_and_surname
    self.name = self.name.namecase
    self.surname = self.surname.namecase
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
    self.odat_diagnoses.first || nil
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
    has_any_attr?([:handicap, :dependency_degree])
  end

  comma do 
    full_name
    center :name => 'Center name'
    province :name => 'Province name'
    city
    address
    postal 'Postal code'
    birth_position
    birth_date
    archive_date
    gender
    father_name
    father_surname
    father_birth_date
    father_job :name => 'Father job'
    father_civil_state :name => 'Father civil state'
    father_job_status :name => 'Father job status'
    father_formation_level :name => 'Father formation level'
    father_email
    father_extra_information
    mother_name
    mother_surname
    mother_birth_date
    mother_job :name => 'Mother job'
    mother_civil_state :name => 'Mother civil state'
    mother_job_status :name => 'Mother job status'
    mother_formation_level :name => 'Mother formation level'
    mother_email
    mother_extra_information
    home_phone
    portable_phone
    work_phone
    total_siblings_amount
    sanitary_services
    social_services
    educative_services
    created_at
    multiple_birth
    position_in_siblings
    handicap
    dependency_degree
    school_type :name => 'School type'
  end

  comma :full do 
    full_name
    center :name => 'Center name'
    province :name => 'Province name'
    city
    address
    postal 'Postal code'
    birth_position
    birth_date
    archive_date
    gender
    father_name
    father_surname
    father_birth_date
    father_job :name => 'Father job'
    father_civil_state :name => 'Father civil state'
    father_job_status :name => 'Father job status'
    father_formation_level :name => 'Father formation level'
    father_email
    father_extra_information
    mother_name
    mother_surname
    mother_birth_date
    mother_job :name => 'Mother job'
    mother_civil_state :name => 'Mother civil state'
    mother_job_status :name => 'Mother job status'
    mother_formation_level :name => 'Mother formation level'
    mother_email
    mother_extra_information
    home_phone
    portable_phone
    work_phone
    total_siblings_amount
    sanitary_services
    social_services
    educative_services
    created_at
    multiple_birth
    position_in_siblings
    handicap
    dependency_degree
    school_type :name => 'School type'

    diagnosis_origin_source = lambda { |odat_diagnoses| odat_diagnoses.first.origin_source.name rescue '' }
    diagnosis_origin_cause = lambda { |odat_diagnoses| odat_diagnoses.first.origin_cause.name rescue '' }
    diagnosis_consultation_cause = lambda { |odat_diagnoses| odat_diagnoses.first.consultation_cause.name rescue '' }
    diagnosis_description = lambda { |odat_diagnoses| odat_diagnoses.first.description rescue '' }
    diagnosis_center_resources = lambda { |odat_diagnoses| odat_diagnoses.first.center_resources.map { |r| r.name }.join(';') rescue '' }
    diagnosis_diagnosis_items = lambda { |odat_diagnoses| odat_diagnoses.first.diagnosis_items.map { |d| d.name }.join(';') rescue '' }
    diagnosis_main_diagnosis = lambda { |odat_diagnoses| odat_diagnoses.first.main_diagnosis.name rescue '' }
    diagnosis_evaluation_category_scores = lambda do |odat_diagnoses| 
      if odat_diagnoses.first
        EvaluationCategory.all.map do |ec|
          ec.name + ': ' + odat_diagnoses.first.get_evaluation_category_score(ec.id).to_s
        end.join(';')
      else
        ''
      end
    end

    odat_diagnoses diagnosis_origin_source => 'Diagnosis origin source'
    odat_diagnoses diagnosis_origin_cause => 'Diagnosis origin cause'
    odat_diagnoses diagnosis_consultation_cause => 'Diagnosis consultation cause'
    odat_diagnoses diagnosis_description => 'Diagnosis description'
    odat_diagnoses diagnosis_center_resources => 'Diagnosis center resources'
    odat_diagnoses diagnosis_diagnosis_items => 'Diagnosis items'
    odat_diagnoses diagnosis_main_diagnosis => 'Diagnosis main diagnosis'
    odat_diagnoses diagnosis_evaluation_category_scores => 'Diagnosis evaluation category scores'
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
