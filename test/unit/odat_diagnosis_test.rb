require 'test_helper'

class OdatDiagnosisTest < ActiveSupport::TestCase
  test "create new valid odat diagnosis" do
    odat_diagnosis = create_odat_diagnosis
    assert odat_diagnosis.valid?
  end

  test "requires medical_record_id" do
    odat_diagnosis = create_odat_diagnosis(:medical_record_id => nil)

    assert !odat_diagnosis.valid?
    assert odat_diagnosis.errors.invalid?(:medical_record_id)
  end

  test "requires origin_source_id" do
    odat_diagnosis = create_odat_diagnosis(:origin_source_id => nil)

    assert !odat_diagnosis.valid?
    assert odat_diagnosis.errors.invalid?(:origin_source_id)
  end

  test "requires origin_cause_id" do
    odat_diagnosis = create_odat_diagnosis(:origin_cause_id => nil)

    assert !odat_diagnosis.valid?
    assert odat_diagnosis.errors.invalid?(:origin_cause_id)
  end

  test "requires consultation_cause_id" do
    odat_diagnosis = create_odat_diagnosis(:consultation_cause_id => nil)

    assert !odat_diagnosis.valid?
    assert odat_diagnosis.errors.invalid?(:consultation_cause_id)
  end

  test "requires main_diagnosis_item_id" do
    odat_diagnosis = create_odat_diagnosis(:main_diagnosis_item_id => nil)

    assert !odat_diagnosis.valid?
    assert odat_diagnosis.errors.invalid?(:main_diagnosis_item_id)
  end

  test "When destroyed all the associated individual reports are removed too" do
    OdatDiagnosis.any_instance.stubs(:valid?).returns(:true)
    odat_diagnosis = create_odat_diagnosis
    report = odat_diagnosis.individual_reports.build
    IndividualReport.any_instance.stubs(:valid?).returns(:true)
    assert report.save

    odat_diagnosis.destroy

    begin
      report.reload
      assert false
    rescue
      assert true
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
      assert_equal ec.default_value, odat_diagnosis.get_evaluation_category_score_for(ec)
    end
  end

  test "returns evaluation_category_score stored" do
    assert_equal(2.5, odat_diagnoses(:one).get_evaluation_category_score_for(evaluation_categories(:two)))
  end

  test "returns default value for evaluation_category when score not stored" do
    assert_equal(evaluation_categories(:three).default_value, odat_diagnoses(:one).get_evaluation_category_score_for(evaluation_categories(:three)))
  end


protected

  def create_odat_diagnosis(opts = {})
    o = new_odat_diagnosis(opts)
    o.save
    o
  end

  def new_odat_diagnosis(opts = {})
    OdatDiagnosis.new({
      :medical_record_id => medical_records(:pedrito).id,
      :origin_source_id => origin_sources(:one).id,
      :origin_cause_id => origin_causes(:one).id,
      :consultation_cause_id => consultation_causes(:one).id,
      :main_diagnosis_item_id => diagnosis_items(:e1_1_1).id
    }.merge!(opts))
  end

end
