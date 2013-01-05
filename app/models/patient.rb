class Patient < ActiveRecord::Base
  attr_accessible :belongs_to, :identifier

  belongs_to :doctor
  has_many :readings

  def systolic_average
    arr = self.readings.map(&:systolic)
    arr.inject { |sum, el| sum + el }.to_f / arr.size
  end  

  def diastolic_average
    arr = self.readings.map(&:diastolic)
    arr.inject { |sum, el| sum + el }.to_f / arr.size
  end
  def readings_chart
    @readings = self.readings
    
    systolic_array = @readings.map(&:systolic)
    diastolic_array = @readings.map(&:diastolic)
    pulse_array = @readings.map(&:pulse)
    dates_array = @readings.map { |d| d.created_at.to_s }

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({ text: 'Blood pressure chart' })
      f.series(name: "Systolic", data: systolic_array)
      f.series(name: "Diastolic", data: diastolic_array)
      f.series(type: 'spline', name: 'Pulse', data: pulse_array)
      f.options[:xAxis][:categories] = dates_array
    end
  end
end
