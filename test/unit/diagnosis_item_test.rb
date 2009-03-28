require 'test_helper'

class DiagnosisItemTest < ActiveSupport::TestCase
  def test_validations
    diagnosis = DiagnosisItem.new
    assert !diagnosis.valid?
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
end
