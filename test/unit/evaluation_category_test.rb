require 'test_helper'

class EvaluationCategoryTest < ActiveSupport::TestCase

  test "returns validates score in range" do
    assert evaluation_categories(:two).accepts_score?(1.5)
  end

  test "returns validates score = min_range" do
    assert evaluation_categories(:two).accepts_score?(1.0)
  end

  test "returns validates score = max_range" do
    assert evaluation_categories(:two).accepts_score?(3.0)
  end

  test "returns validates score = nil in category that accepts nil" do
    assert evaluation_categories(:one).accepts_score?(nil)
  end

  test "returns don't validates score = nil in category that doesn't accept nil" do
    assert !evaluation_categories(:two).accepts_score?(nil)
  end
end
