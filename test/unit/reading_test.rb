require 'test_helper'

class ReadingTest < ActiveSupport::TestCase
  test "average of no readings is nothing" do
    assert_equal 0, Reading.averages([]).systolic
    assert_equal 0, Reading.averages([]).diastolic
  end
end
