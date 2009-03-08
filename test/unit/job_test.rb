require 'test_helper'

class JobTest < ActiveSupport::TestCase
  def new_valid_entity
    job = Job.new
    job.name = 'Trabajo 1'
    return job
  end

  def test_invalid_default_attributes
    job =  Job.new

    assert !job.valid?
    assert job.errors.invalid?(:name)
  end

  def test_new_valid
    job = new_valid_entity
    assert job.valid?
  end
end
