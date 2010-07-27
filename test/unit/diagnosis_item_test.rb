require 'test_helper'

class DiagnosisItemTest < ActiveSupport::TestCase
  def test_validations
    diagnosis = DiagnosisItem.new
    assert !diagnosis.valid?
    assert diagnosis.errors.invalid?(:name)
  end

  def test_create_valid
    diagnosis = DiagnosisItem.new(:name => 'item1',
				  :description => '*tested*')
    diagnosis.save
    assert diagnosis.valid?
  end

  def test_filtered_description
    diagnosis = DiagnosisItem.new(:name => 'item1',
				  :description => '*tested*')
    diagnosis.save
    assert diagnosis.valid?
    assert !diagnosis.description_html.nil?  && 
      !diagnosis.description_html.empty?
    assert_equal "<p><strong>tested</strong></p>", diagnosis.description_html
  end

  def test_subcategory_is_children_of_category_and_root
    assert diagnosis_items(:c1).is_ancestor_of?(diagnosis_items(:s1_1))
    assert !diagnosis_items(:c1).is_ancestor_of?(diagnosis_items(:s2_1))
  end

  def test_ancestors
    assert 3, diagnosis_items(:e1_1_1).ancestors.count
    assert 3, diagnosis_items(:e1_1_2).ancestors.count
  end

  def test_self_and_ancestors
    assert 4, diagnosis_items(:e1_1_1).self_and_ancestors.count
    assert 4, diagnosis_items(:e1_1_2).self_and_ancestors.count
  end

  test "shoul return true to includes_any? if any is included" do
    assert diagnosis_items(:s1_1).is_ancestor_of_any?(
      [diagnosis_items(:e1_1_1)])
  end

  test "shoul return true to includes_any? if any is included multiple" do
    assert diagnosis_items(:s1_1).is_ancestor_of_any?(
      [diagnosis_items(:e1_1_1),
        diagnosis_items(:e1_1_2)])
  end

  test "shoul return false to includes_any? if none is included multiple" do
    assert !diagnosis_items(:s1_1).is_ancestor_of_any?([])
  end

  test "shoul return false to includes_any? if subcat has no children" do
    assert !diagnosis_items(:s2_2).is_ancestor_of_any?([])
  end
end
