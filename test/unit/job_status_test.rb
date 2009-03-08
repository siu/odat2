require 'test_helper'

class JobStatusTest < ActiveSupport::TestCase
  def new_valid_entity
    job_status = JobStatus.new
    job_status.name = 'Trabajando'
    return job_status
  end

  def test_invalid_default_attributes
    job_status =  JobStatus.new

    assert !job_status.valid?
    assert job_status.errors.invalid?(:name)
  end

  def test_new_valid
    job_status = new_valid_entity
    assert job_status.valid?
  end
end
