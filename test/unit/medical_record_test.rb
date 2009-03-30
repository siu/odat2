require 'test_helper'

class MedicalRecordTest < ActiveSupport::TestCase
protected
  def new_valid_medical_record(options = {})
    medical_record = MedicalRecord.new
    medical_record.name = options[:name] || 'Test1'
    medical_record.surname = options[:surname] || 'Surname 1'
    medical_record.center = options[:center] || centers(:demo)
    medical_record.created_at = Time.now
    return medical_record
  end

public
  should "be invalid if created with default attributes" do
    medical_record =  MedicalRecord.new

    assert !medical_record.valid?

    assert medical_record.errors.invalid?(:name)
    assert medical_record.errors.invalid?(:surname)
    assert medical_record.errors.invalid?(:center)

    assert medical_record.errors.invalid?(:created_at)
  end

  should "not let create two records with the same name for the same center" do
    medical_record = new_valid_medical_record(
      :name => 'Name 1', :surname => 'Surname 1', :center => centers(:demo))
    medical_record.save
    assert medical_record.valid?

    medical_record = new_valid_medical_record(
      :name => 'Name 1', :surname => 'Surname 1', :center => centers(:demo))
    medical_record.save
    assert !medical_record.valid?

    assert_equal 1, medical_record.errors.size
  end

  should "let create two records with the same name for different same centers" do
    medical_record = new_valid_medical_record(
      :name => 'Name 1', :surname => 'Surname 1', :center => centers(:demo))
    medical_record.save
    assert medical_record.valid?

    medical_record = new_valid_medical_record(
      :name => 'Name 1', :surname => 'Surname 1', :center => centers(:demo2))
    medical_record.save
    assert medical_record.valid?
  end


  should "be valid if postal code is empty" do
    medical_record = new_valid_medical_record
    medical_record.postal = ''

    assert !medical_record.errors.invalid?(:postal)
  end

  should "be invalid if postal code is an string" do
    medical_record = new_valid_medical_record
    medical_record.postal = 'error'

    assert !medical_record.valid?

    assert medical_record.errors.invalid?(:postal)
  end

  def test_invalid_postal_if_length_differs_5
    medical_record = new_valid_medical_record
    medical_record.postal = '123'

    assert !medical_record.valid?

    assert medical_record.errors.invalid?(:postal)
  end

  def test_valid_postal_if_length_equals_5
    medical_record = new_valid_medical_record
    medical_record.postal = '12345'

    medical_record.valid?
    assert !medical_record.errors.invalid?(:postal)
  end

  def test_region_should_be_the_same_as_the_center
    medical_record = new_valid_medical_record
    assert medical_record.region == medical_record.center.region
  end

  def test_birth_position_should_be_numeric
    medical_record = new_valid_medical_record
    medical_record.birth_position = 'test'

    medical_record.valid?
    assert medical_record.errors.invalid?(:birth_position)
  end

  def test_full_name
    medical_record = new_valid_medical_record
    assert medical_record.full_name == 
      medical_record.surname + ', ' + medical_record.name
  end
end
