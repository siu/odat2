require 'test_helper'

class FormationLevelTest < ActiveSupport::TestCase
  def new_valid_entity
    formation_level = FormationLevel.new
    formation_level.name = 'adf'
    return formation_level
  end

  def test_invalid_default_attributes
    formation_level =  FormationLevel.new

    assert !formation_level.valid?
    assert formation_level.errors.invalid?(:name)
  end

  def test_new_valid
    formation_level = new_valid_entity
    assert formation_level.valid?
  end
end
