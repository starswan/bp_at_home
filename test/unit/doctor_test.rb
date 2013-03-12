require 'test_helper'

class DoctorTest < ActiveSupport::TestCase
  should have_many(:patients)

  should validate_presence_of(:name)
  should validate_presence_of(:email)
  should validate_presence_of(:practice)
  should validate_uniqueness_of(:email)

end