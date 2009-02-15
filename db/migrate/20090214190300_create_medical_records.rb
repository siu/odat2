class CreateMedicalRecords < ActiveRecord::Migration
  def self.up
    create_table :medical_records do |t|
      # Relations
      t.integer :center_id, :null => false

      # General patient infomation
      t.string  :name, :limit => 25, :null => false
      t.string  :surname, :limit => 50, :null => false
      t.date    :birth_date
      t.date    :archive_date
      t.integer :region_id
      t.string  :city, :limit => 40
      t.string  :address, :limit => 60
      t.integer :birth_position, :limit => 4
      t.string  :gender, :limit => 9

      # Related to the father
      t.string  :father_name, :limit => 25
      t.string  :father_surname, :limit => 50
      t.date    :father_birth_date
      t.integer :father_job_id
      t.integer :father_civil_state_id
      t.integer :father_job_situation_id
      t.integer :father_study_level_id
      t.string  :father_email,   :limit => 30
      t.text    :father_extra_information

      # Related to the mother
      t.string  :mother_name, :limit => 25
      t.string  :mother_surname, :limit => 50
      t.date    :mother_birth_date
      t.integer :mother_job_id
      t.integer :mother_civil_state_id
      t.integer :mother_job_situation_id
      t.integer :mother_study_level_id
      t.string  :mother_email,   :limit => 30
      t.text    :mother_extra_information

      # Extra data
      t.string  :home_phone, :limit => 9
      t.string  :portable_phone, :limit => 9
      t.string  :job_phone, :limit => 9
      t.integer :total_siblings_amount, :limit => 6
      t.string	:postal, :limit => 5
      t.integer :birth_position,  :limit => 2
      t.boolean :sanitary_services
      t.boolean :social_services
      t.boolean :educative_services

      t.timestamps
    end
  end

  def self.down
    drop_table :medical_records
  end
end
