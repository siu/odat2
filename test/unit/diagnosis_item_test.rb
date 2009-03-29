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

  def test_should_create_test_tree
    create_test_tree
    assert_equal 9, DiagnosisItem.find(:all).size
  end

  def test_root_is_root
    create_test_tree
    d = DiagnosisItem.root
    assert d.root?
  end

  def test_should_return_categories
    create_test_tree
    diagnoses = DiagnosisItem.categories
    assert !diagnoses.nil?
    assert_equal 3, diagnoses.size
  end

  def test_should_return_subcategories
    create_test_tree
    diagnoses = DiagnosisItem.subcategories
    assert !diagnoses.nil?
    assert_equal 5, diagnoses.size
  end

  def test_category_should_return_subcategories
    create_test_tree
    category = DiagnosisItem.categories.first
    assert !category.nil?
    assert_equal 3, category.subcategories.size
  end

  def test_subcategory_is_children_of_category_and_root
    create_test_tree
    assert @c1.is_parent?(@s1_1)
    assert @r.is_parent?(@s1_1)

    assert !@c1.is_parent?(@s2_1)
    assert @r.is_parent?(@s2_1)
  end

protected
  def create_test_tree
    # Create the root node
    @r = DiagnosisItem.create(
	  :id => 1, # This makes no effect, but it assigns 1 to root by default
	  :name => 'Root', 
	  :description => 'Root node')

    # Create the 3 main categories
    @c1 = DiagnosisItem.create(
	  :name => 'Cat1', 
	  :description => 'Description of cat 1')
    @r.add_child(@c1)
    @c2 = DiagnosisItem.create(
	  :name => 'Cat2', 
	  :description => 'Description of cat 2')
    @r.add_child(@c2)
    @c3 = DiagnosisItem.create(
	  :name => 'Cat3', 
	  :description => 'Description of cat 3')
    @r.add_child(@c3)

    # Create 3 subcategories for category 1
    @s1_1 = DiagnosisItem.create(
	  :name => 'Subcat 1.1', 
	  :description => 'Description of subcategory 1.1')
    @c1.add_child(@s1_1)
    @s1_2 = DiagnosisItem.create(
	  :name => 'Subcat 1.2', 
	  :description => 'Description of subcategory 1.2')
    @c1.add_child(@s1_2)
    @s1_3 = DiagnosisItem.create(
	  :name => 'Subcat 1.3', 
	  :description => 'Description of subcategory 1.3')
    @c1.add_child(@s1_3)

    # Create 2 subcategories for category 2
    @s2_1 = DiagnosisItem.create(
	  :name => 'Subcat 2.1', 
	  :description => 'Description of subcategory 2.1')
    @c2.add_child(@s2_1)
    @s2_2 = DiagnosisItem.create(
	  :name => 'Subcat 2.2', 
	  :description => 'Description of subcategory 2.2')
    @c2.add_child(@s2_2)

    # It is needed to reload all objects to update the internal variables
    [@r, @c1, @c2, @c3, @s1_1, @s1_2, @s1_3, @s2_1, @s2_2].each do |i| 
	i.reload
    end
  end

end
