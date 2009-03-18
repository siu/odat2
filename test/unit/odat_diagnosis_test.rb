require 'test_helper'

class OdatDiagnosisTest < ActiveSupport::TestCase
  def get_new_valid_entity
    odat_diagnosis = OdatDiagnosis.new
    odat_diagnosis.medical_record = medical_records(:pedrito)
    odat_diagnosis.created_at = Time.now
    
    odat_diagnosis.build_origin_source()
    odat_diagnosis.build_origin_cause()
    odat_diagnosis.build_consultation_cause()

    return odat_diagnosis
  end

  def test_create_new
    odat_diagnosis = get_new_valid_entity
    assert odat_diagnosis.valid?
  end

  def test_create_new_invalid
    odat_diagnosis = OdatDiagnosis.new

    assert !odat_diagnosis.valid?

    assert odat_diagnosis.errors.invalid?(:medical_record)
    assert odat_diagnosis.errors.invalid?(:created_at)
    assert odat_diagnosis.errors.invalid?(:origin_source)
    assert odat_diagnosis.errors.invalid?(:origin_cause)
    assert odat_diagnosis.errors.invalid?(:consultation_cause)
  end
end
