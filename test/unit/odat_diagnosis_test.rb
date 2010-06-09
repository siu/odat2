require 'test_helper'

class OdatDiagnosisTest < ActiveSupport::TestCase
  test "should be invalid if created with default attributes" do
    odat_diagnosis = OdatDiagnosis.new
    assert !odat_diagnosis.valid?

    assert odat_diagnosis.errors.invalid?(:medical_record)
    assert odat_diagnosis.errors.invalid?(:origin_source)
    assert odat_diagnosis.errors.invalid?(:origin_cause)
    assert odat_diagnosis.errors.invalid?(:consultation_cause)
    assert odat_diagnosis.errors.invalid?(:main_diagnosis)
  end

  test "create new valid odat diagnosis" do
    odat_diagnosis = create_odat_diagnosis
    assert odat_diagnosis.valid?
  end

  test "requires medical_record" do
    odat_diagnosis = create_odat_diagnosis(:medical_record => nil)

    assert !odat_diagnosis.valid?
    assert odat_diagnosis.errors.invalid?(:medical_record)
  end

  test "requires origin_source" do
    odat_diagnosis = create_odat_diagnosis(:origin_source => nil)

    assert !odat_diagnosis.valid?
    assert odat_diagnosis.errors.invalid?(:origin_source)
  end

  test "requires origin_cause" do
    odat_diagnosis = create_odat_diagnosis(:origin_cause => nil)

    assert !odat_diagnosis.valid?
    assert odat_diagnosis.errors.invalid?(:origin_cause)
  end

  test "requires consultation_cause" do
    odat_diagnosis = create_odat_diagnosis(:consultation_cause => nil)

    assert !odat_diagnosis.valid?
    assert odat_diagnosis.errors.invalid?(:consultation_cause)
  end

  test "requires main_diagnosis" do
    odat_diagnosis = create_odat_diagnosis(:main_diagnosis => nil)

    assert !odat_diagnosis.valid?
    assert odat_diagnosis.errors.invalid?(:main_diagnosis)
  end


  test "When destroyed all the associated individual reports are removed too" do
    # TODO: There is a bug somewhere in the rails/mocka stack, if I enable the following
    # line all future instances of OdatDiagnosis return always true to valid?
    #OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)
    odat_diagnosis = create_odat_diagnosis
    report = odat_diagnosis.individual_reports.create
    IndividualReport.any_instance.stubs(:valid?).returns(:true)
    assert report.save

    odat_diagnosis.destroy

    assert_raises ActiveRecord::RecordNotFound do
      report.reload
    end
  end

protected

  def create_odat_diagnosis(opts = {})
    o = new_odat_diagnosis(opts)
    o.save
    o
  end

  def new_odat_diagnosis(opts = {})
    OdatDiagnosis.new({
      :medical_record => medical_records(:pedrito),
      :origin_source => origin_sources(:one),
      :origin_cause => origin_causes(:one),
      :consultation_cause => consultation_causes(:one),
      :main_diagnosis => diagnosis_items(:e1_1_1)
    }.merge!(opts))
  end

end
