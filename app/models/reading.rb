class Reading < ActiveRecord::Base
  belongs_to :patient

  validates :systolic, :diastolic, :created_at, presence: true
  validates_numericality_of :systolic, greater_than_or_equal_to: 70, less_than_or_equal_to: 240, only_integer: true
  validates_numericality_of :diastolic, greater_than_or_equal_to: 30, less_than_or_equal_to: 130, only_integer: true

  Averages = Struct.new :systolic, :diastolic

  def self.averages readings
    recent_readings = (readings[-10..-1] or readings)
    if recent_readings.empty?
      Averages.new 0, 0
    else
      Averages.new((recent_readings.map { |k| k.systolic }.sum / recent_readings.size),
                   (recent_readings.map { |k| k.diastolic }.sum / recent_readings.size))
    end
  end
end
