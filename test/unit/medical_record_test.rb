require 'test_helper'

class MedicalRecordTest < ActiveSupport::TestCase
  test "should be invalid if created with default attributes" do
    medical_record =  MedicalRecord.new

    assert !medical_record.valid?

    assert medical_record.errors.invalid?(:name)
    assert medical_record.errors.invalid?(:surname)
    assert medical_record.errors.invalid?(:center)

    assert medical_record.errors.invalid?(:archive_date)
  end

  test "should not let create two records with the same name for the same center" do
    attributes = {
      :name => 'Name 1', 
      :surname => 'Surname 1', 
      :center => centers(:demo)}

    medical_record = create_medical_record(attributes)
    assert medical_record.valid?

    medical_record = create_medical_record(attributes)
    assert !medical_record.valid?

    assert_equal 1, medical_record.errors.size
  end

  test "should let create two records with the same name for different centers" do

    attributes = {
      :name => 'Name 1', 
      :surname => 'Surname 1', 
      :center => centers(:demo)}

    medical_record = create_medical_record(attributes)
    assert medical_record.valid?

    attributes.merge!(:center => centers(:demo2))

    medical_record = create_medical_record(attributes)
    assert medical_record.valid?
  end


  test "should be valid if postal code is empty" do
    medical_record = create_medical_record(:postal => '')

    assert !medical_record.errors.invalid?(:postal)
  end

  test "should be invalid if postal code is an string" do
    medical_record = create_medical_record(:postal => 'error')

    assert !medical_record.valid?

    assert medical_record.errors.invalid?(:postal)
  end

  def test_invalid_postal_if_length_differs_5
    medical_record = create_medical_record(:postal => '123')

    assert !medical_record.valid?

    assert medical_record.errors.invalid?(:postal)
  end

  def test_valid_postal_if_length_equals_5
    medical_record = create_medical_record(:postal => '12345')

    medical_record.valid?
    assert !medical_record.errors.invalid?(:postal)
  end

  def test_birth_position_should_be_numeric
    medical_record = create_medical_record(:birth_position => 'test')

    medical_record.valid?
    assert medical_record.errors.invalid?(:birth_position)
  end

  test "position_in_siblings should be numeric" do
    medical_record = create_medical_record(:position_in_siblings => 'test')

    medical_record.valid?
    assert medical_record.errors.invalid?(:position_in_siblings)
  end

  test "dependency_degree should be in 1..4" do
    medical_record = create_medical_record(:dependency_degree => 'test')
    assert !medical_record.valid?
    assert medical_record.errors.invalid?(:dependency_degree)

    medical_record = create_medical_record(:dependency_degree => '1')
    assert medical_record.valid?

    medical_record = create_medical_record(:dependency_degree => '5')
    assert !medical_record.valid?
    assert medical_record.errors.invalid?(:dependency_degree)
  end

  test "dependency_situation should be in 1..3" do
    medical_record = create_medical_record(:dependency_situation => 'test')
    assert !medical_record.valid?
    assert medical_record.errors.invalid?(:dependency_situation)

    medical_record = create_medical_record(:dependency_situation => '1')
    assert medical_record.valid?

    medical_record = create_medical_record(:dependency_situation => '4')
    assert !medical_record.valid?
    assert medical_record.errors.invalid?(:dependency_situation)
  end

  test "accepts SchoolType" do
    medical_record = create_medical_record(:school_type_id => school_types(:one).id)

    assert medical_record.valid?
  end

  def test_full_name
    medical_record = create_medical_record()
    assert medical_record.full_name == 
      medical_record.name + ' ' + medical_record.surname
  end

  test "doesn't have siblings data" do
    medical_record = create_medical_record()
    assert !medical_record.has_siblings_data?
  end

  test "doesn't have siblings data if nil data" do
    medical_record = create_medical_record(:total_siblings_amount => nil)
    assert !medical_record.has_siblings_data?
    medical_record = create_medical_record(:birth_position => nil)
    assert !medical_record.has_siblings_data?
  end

  test "has siblings data" do
    medical_record = create_medical_record(:total_siblings_amount => 2)
    assert medical_record.has_siblings_data?
    medical_record = create_medical_record(:birth_position => 2)
    assert medical_record.has_siblings_data?
  end

  test "doesn't have father data" do
    medical_record = create_medical_record()
    assert !medical_record.has_father_data?
  end

  test "doesn't have father data if empty data" do
    [:father_name, :father_surname, :father_job_id, :father_civil_state_id, :father_job_status_id, :father_formation_level_id, :father_email, :father_extra_information].each do |a|
      medical_record = create_medical_record(a => '')
      assert !medical_record.has_father_data?, a
    end
  end

  test "has father data" do
    [:father_name, :father_surname, :father_job_id, :father_civil_state_id, :father_job_status_id, :father_formation_level_id, :father_email, :father_extra_information].each do |a|
      medical_record = create_medical_record(a => '1')
      assert medical_record.has_father_data?, a
    end
    medical_record = create_medical_record(:father_birth_date => Time.now)
    assert medical_record.has_father_data?
  end

  test "doesn't have mother data" do
    medical_record = create_medical_record()
    assert !medical_record.has_mother_data?
  end

  test "doesn't have mother data if empty data" do
    [:mother_name, :mother_surname, :mother_job_id, :mother_civil_state_id, :mother_job_status_id, :mother_formation_level_id, :mother_email, :mother_extra_information].each do |a|
      medical_record = create_medical_record(a => '')
      assert !medical_record.has_mother_data?, a
    end
  end

  test "has mother data" do
    [:mother_name, :mother_surname, :mother_job_id, :mother_civil_state_id, :mother_job_status_id, :mother_formation_level_id, :mother_email, :mother_extra_information].each do |a|
      medical_record = create_medical_record(a => '1')
      assert medical_record.has_mother_data?, a
    end
    medical_record = create_medical_record(:mother_birth_date => Time.now)
    assert medical_record.has_mother_data?
  end

  test "doesn't have phone data" do
    medical_record = create_medical_record()
    assert !medical_record.has_phone_data?
  end

  test "doesn't have phone data if empty data" do
    [:home_phone, :portable_phone, :work_phone].each do |a|
      medical_record = create_medical_record(a => '')
      assert !medical_record.has_phone_data?, a
    end
  end

  test "has phone data" do
    [:home_phone, :portable_phone, :work_phone].each do |a|
      medical_record = create_medical_record(a => '1')
      assert medical_record.has_phone_data?, a
    end
  end

  test "doesn't have coordination data" do
    medical_record = create_medical_record()
    assert !medical_record.has_phone_data?
  end

  test "doesn't have coordination data if empty data" do
    [:sanitary_services, :social_services, :educative_services].each do |a|
      medical_record = create_medical_record(a => '')
      assert !medical_record.has_coordination_data?
    end
  end

  test "doesn't have coordination data if false data" do
    [:sanitary_services, :social_services, :educative_services].each do |a|
      medical_record = create_medical_record(a => false)
      assert !medical_record.has_coordination_data?
    end
  end

  test "has coordination data" do
    [:sanitary_services, :social_services, :educative_services].each do |a|
      medical_record = create_medical_record(a => true)
      assert medical_record.has_coordination_data?
    end
  end

  test "has handicap data" do
    medical_record = create_medical_record(:handicap => true)
    assert medical_record.has_handicap_data?

    [:dependency_degree, :dependency_situation].each do |a|
      medical_record = create_medical_record(a => '2')
      assert medical_record.has_handicap_data?
    end
  end

  test "clone_last_or_new_odat_diagnosis returns new odat_diagnosis if no previous" do
    medical_record = create_medical_record()
    odat_diagnosis = medical_record.clone_last_or_new_odat_diagnosis
    assert odat_diagnosis.new_record?
    assert odat_diagnosis.center_resources.empty?
    assert odat_diagnosis.diagnosis_items.empty?
    assert odat_diagnosis.main_diagnosis.nil?
  end

  test "clone_last_or_new_odat_diagnosis returns a new copy of odat_diagnosis if previous" do
    medical_record = create_medical_record()
    odat_diagnosis = medical_record.clone_last_or_new_odat_diagnosis

    odat_diagnosis.created_at = Time.now
    odat_diagnosis.medical_record = medical_records(:pedrito)
    odat_diagnosis.origin_source = origin_sources(:one)
    odat_diagnosis.origin_cause = origin_causes(:one)
    odat_diagnosis.consultation_cause = consultation_causes(:one)
    odat_diagnosis.center_resources = [center_resources(:one)]
    odat_diagnosis.diagnosis_items = [
      diagnosis_items(:e1_1_1), 
      diagnosis_items(:e1_1_2)
    ]
    odat_diagnosis.main_diagnosis = diagnosis_items(:e1_1_2)
    assert medical_record.save, medical_record.errors.inspect
    assert medical_record.valid?
    assert !odat_diagnosis.new_record?
    assert_equal 1, odat_diagnosis.center_resources.size
    assert_equal 2, odat_diagnosis.diagnosis_items.size
    assert_equal diagnosis_items(:e1_1_2), odat_diagnosis.main_diagnosis

    odat_diagnosis = medical_record.clone_last_or_new_odat_diagnosis

    assert odat_diagnosis.new_record?
    assert_equal 1, odat_diagnosis.center_resources.size
    assert_equal 2, odat_diagnosis.diagnosis_items.size
    assert_equal diagnosis_items(:e1_1_2), odat_diagnosis.main_diagnosis

    assert odat_diagnosis.save
    assert odat_diagnosis.valid?
    assert !odat_diagnosis.new_record?
  end

  test "should remove all associated individual reports if deleted" do
    medical_record = medical_records(:pedrito)
    report = medical_record.individual_reports.first
    medical_record.destroy

    assert_raises ActiveRecord::RecordNotFound do
      report.reload
    end
  end

  test "should remove all associated odat diagnoses if deleted" do
    medical_record = medical_records(:pedrito)
    odat_diagnosis = medical_record.odat_diagnoses.first
    medical_record.destroy

    assert_raises ActiveRecord::RecordNotFound do
      odat_diagnosis.reload
    end
  end
protected
  def create_medical_record(options = {})
    MedicalRecord.create({:name => 'Test1',
      :surname => 'Surname 1',
      :center => centers(:demo),
      :archive_date => Time.now,
      :created_at => Time.now}.merge!(options))
  end
end
