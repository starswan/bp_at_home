class Reading < ActiveRecord::Base
  attr_accessible :diastolic, :patient_id, :pulse, :systolic

  belongs_to :patient

  validates :systolic, :diastolic, :pulse, presence: true
end
