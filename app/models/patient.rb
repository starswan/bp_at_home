class Patient < ActiveRecord::Base
  attr_accessible :identifier

  belongs_to :doctor
  has_many :readings

  def sys_average(array=[])
    if readings.count < 1
      return "0"
    else
      readings.each { |r| array << r.systolic }
      return array.inject { |sum, el| sum + el } / array.size
    end
  end

  def dys_average(array=[])
    if readings.count < 1
      return "0"
    else
      readings.each { |r| array << r.diastolic }
      return array.inject { |sum, el| sum + el } / array.size
    end
  end

  def pulse_average(array=[])
    if readings.count < 1
      return "0"
    else
      readings.each { |r| array << r.pulse }
      return array.inject { |sum, el| sum + el } / array.size
    end
  end

  def readings_chart
    # get the readings
    @readings = self.readings
    # create the arrays of values for the chart 
    systolic_array = @readings.map(&:systolic)
    diastolic_array = @readings.map(&:diastolic)
    pulse_array = @readings.map(&:pulse)
    dates_array = []
    @readings.order(:created_at).each { |r| (dates_array << r.created_at.strftime('%d %B')) if r.created_at }
    # plot the chart
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({ text: 'Your Blood Pressure Chart' })
      f.series(name: "Systolic", data: systolic_array)
      f.series(name: "Diastolic", data: diastolic_array)
      f.series(name: 'Pulse', data: pulse_array)
      f.options[:xAxis][:categories] = dates_array
    end
  end
end
