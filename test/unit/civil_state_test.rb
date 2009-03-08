require 'test_helper'

class CivilStateTest < ActiveSupport::TestCase
  def new_valid_entity
    civil_state = CivilState.new
    civil_state.name = 'bee'
    return civil_state
  end

  def test_invalid_default_attributes
    civil_state =  CivilState.new

    assert !civil_state.valid?
    assert civil_state.errors.invalid?(:name)
  end

  def test_new_valid
    civil_state = new_valid_entity
    assert civil_state.valid?
  end
end
