class Reading < ActiveRecord::Base
  attr_accessible :diastolic, :patient_id, :pulse, :systolic, :arm, :created_at

  belongs_to :patient

  validates :systolic, :diastolic, :pulse, :arm, presence: true
  validates_numericality_of :systolic, greater_than_or_equal_to: 80, only_integer: true
  validates_numericality_of :diastolic, greater_than_or_equal_to: 30, only_integer: true

end
