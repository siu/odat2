require 'test_helper'

class MedicalRecordTest < ActiveSupport::TestCase
  def test_invalid_default_attributes
    medical_record =  MedicalRecord.new

    assert !medical_record.valid?

    assert medical_record.errors.invalid?(:name)
    assert medical_record.errors.invalid?(:surname)
    assert medical_record.errors.invalid?(:center)

    assert medical_record.errors.invalid?(:created_at)
  end


  def test_valid_postal_if_empty
    medical_record =  MedicalRecord.new(:name => 'test1',
					:surname => 'test1',
					:center => centers(:demo),
					:postal => '')

    assert !medical_record.errors.invalid?(:postal)
  end

  def test_invalid_postal_if_string
    medical_record =  MedicalRecord.new(:name => 'test1',
					:surname => 'test1',
					:center => centers(:demo),
					:postal => 'error')

    assert !medical_record.valid?

    assert medical_record.errors.invalid?(:postal)
  end

  def test_invalid_postal_if_length_differs_5
    medical_record =  MedicalRecord.new(:name => 'test1',
					:surname => 'test1',
					:center => centers(:demo),
					:postal => '123')

    assert !medical_record.valid?

    assert medical_record.errors.invalid?(:postal)
  end

  def test_valid_postal_if_length_equals_5
    medical_record =  MedicalRecord.new(:name => 'test1',
					:surname => 'test1',
					:center => centers(:demo),
					:postal => '12345')

    medical_record.valid?
    assert !medical_record.errors.invalid?(:postal)
  end
end
