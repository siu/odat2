require 'test_helper'

class ConsultationCauseTest < ActiveSupport::TestCase
  test "creates valid" do
    consultation_cause = create_consultation_cause
    assert consultation_cause.valid?
  end

  test "requires name" do
    consultation_cause = create_consultation_cause(:name => nil)
    assert !consultation_cause.valid?
    assert consultation_cause.errors.invalid?(:name)
  end
protected

  def create_consultation_cause(opts = {})
    ConsultationCause.create({
      :name => 'Consultation cause'
    }.merge!(opts))
  end
end
