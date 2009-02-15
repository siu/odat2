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
end
