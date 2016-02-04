class Feedback < ActiveRecord::Base
  attr_accessible :patient_id, :text
end
