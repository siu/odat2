require 'test_helper'

class DiagnosisItemTest < ActiveSupport::TestCase
  def test_validations
    diagnosis = DiagnosisItem.new
    assert !diagnosis.valid?
    assert diagnosis.errors.invalid?(:name)
    assert diagnosis.errors.invalid?(:description)
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

  def test_should_return_categories
    create_test_tree
    diagnoses = DiagnosisItem.categories
    assert !diagnoses.nil?
    assert_equal 3, diagnoses.size
  end

  def test_should_create_test_tree
    create_test_tree
    assert_equal 9, DiagnosisItem.find(:all).size
  end

  def test_first_should_be_a_root
    create_test_tree
    d = DiagnosisItem.find(1)
    assert d.root?
  end

protected
  def create_test_tree
    # Create the root node
    r = DiagnosisItem.create(
	  :id => 1, # This makes no effect, but it assigns 1 by default
	  :name => 'Root', 
	  :description => 'Root node')

    # Create the 3 main categories
    c1 = DiagnosisItem.create(
	  :name => 'Cat1', 
	  :description => 'Description of cat 1')
    r.add_child(c1)
    c2 = DiagnosisItem.create(
	  :name => 'Cat2', 
	  :description => 'Description of cat 2')
    r.add_child(c2)
    c3 = DiagnosisItem.create(
	  :name => 'Cat3', 
	  :description => 'Description of cat 3')
    r.add_child(c3)

    # Create 3 elements for category 1
    e1_1 = DiagnosisItem.create(
	  :name => 'Elem 1.1', 
	  :description => 'Description of element 1.1')
    c1.add_child(e1_1)
    e1_2 = DiagnosisItem.create(
	  :name => 'Elem 1.2', 
	  :description => 'Description of element 1.2')
    c1.add_child(e1_2)
    e1_3 = DiagnosisItem.create(
	  :name => 'Elem 1.3', 
	  :description => 'Description of element 1.3')
    c1.add_child(e1_3)

    # Create 2 elements for category 2
    e2_1 = DiagnosisItem.create(
	  :name => 'Elem 2.1', 
	  :description => 'Description of element 2.1')
    c2.add_child(e2_1)
    e2_2 = DiagnosisItem.create(
	  :name => 'Elem 2.2', 
	  :description => 'Description of element 2.2')
    c2.add_child(e2_2)
  end

end
