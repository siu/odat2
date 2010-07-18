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

  test "evaluation_category_scores are created after initialize" do
    odat_diagnosis = new_odat_diagnosis()

    assert_equal EvaluationCategory.count, odat_diagnosis.evaluation_category_scores.size
  end

  test "evaluation_category_scores size is equal to the number of evaluation categories" do
    odat_diagnosis = odat_diagnoses(:one)

    assert_equal EvaluationCategory.count, odat_diagnosis.evaluation_category_scores.size
  end

  test "evaluation_category_scores are default after initialize" do
    odat_diagnosis = new_odat_diagnosis()

    EvaluationCategory.find_each do |ec|
      assert_equal(ec.default_value, 
                   odat_diagnosis.get_evaluation_category_score(ec.id))
    end
  end

  test "returns evaluation_category_score stored" do
    assert_equal(2.5, 
                 odat_diagnoses(:one).get_evaluation_category_score(evaluation_categories(:two).id))
  end

  test "returns default value for evaluation_category when score not stored" do
    assert_equal(evaluation_categories(:four).default_value, 
                 odat_diagnoses(:one).get_evaluation_category_score(evaluation_categories(:four).id))
  end

  test "doesn't duplicate evaluation_category scores on save" do
    old_size = odat_diagnoses(:one).evaluation_category_scores.count
    odat_diagnoses(:one).save
    new_size = odat_diagnoses(:one).evaluation_category_scores.count

    assert_equal(old_size, new_size)
  end

  test 'get total score' do
    assert_equal(3.6, odat_diagnoses(:one).total_score)
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
