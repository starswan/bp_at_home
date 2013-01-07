class Patient < ActiveRecord::Base
  attr_accessible :identifier

  belongs_to :doctor
  has_many :readings

  def readings_chart
    # get the readings
    @readings = self.readings
    # create the arrays of values for the chart 
    systolic_array = @readings.map(&:systolic)
    diastolic_array = @readings.map(&:diastolic)
    pulse_array = @readings.map(&:pulse)
    dates_array = @readings.map { created_at.to_s(:short) }
    # plot the chart
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({ text: 'Blood pressure chart' })
      f.series(name: "Systolic", data: systolic_array)
      f.series(name: "Diastolic", data: diastolic_array)
      f.series(type: 'spline', name: 'Pulse', data: pulse_array)
      f.options[:xAxis][:categories] = dates_array
    end
  end
end
