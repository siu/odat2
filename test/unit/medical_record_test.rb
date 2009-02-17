require 'test_helper'

class MedicalRecordTest < ActiveSupport::TestCase
  def new_valid_medical_record
    medical_record = MedicalRecord.new
    medical_record.name = 'Test1'
    medical_record.surname = 'Surname 1'
    medical_record.center = centers(:demo)
    medical_record.created_at = Time.now
    return medical_record
  end

  def test_invalid_default_attributes
    medical_record =  MedicalRecord.new

    assert !medical_record.valid?

    assert medical_record.errors.invalid?(:name)
    assert medical_record.errors.invalid?(:surname)
    assert medical_record.errors.invalid?(:center)

    assert medical_record.errors.invalid?(:created_at)
  end


  def test_valid_postal_if_empty
    medical_record = new_valid_medical_record
    medical_record.postal = ''

    assert !medical_record.errors.invalid?(:postal)
  end

  def test_invalid_postal_if_string
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
