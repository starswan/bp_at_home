class ReadingsController < ApplicationController

  def index
    @patient = Patient.find(params[:patient_id])
    @reading = @patient.readings.new
    
    @readings = @patient.readings
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
  
  def create
    @patient = Patient.find(params[:patient_id])
    @reading = Reading.create(params[:reading])
    if @reading.save
      redirect_to patient_readings_path(@patient), notice: "Reading successfully entered!"
    else
      flash.now.alert = "There was an error. Please try again"
      render :index
    end
  end
end
