class ReadingsController < ApplicationController
  before_filter :authorize_patient!

  def index
    @patient = Patient.find(params[:patient_id])
    @readings = @patient.readings

    @sys_average = @patient.sys_average
    @dys_average = @patient.dys_average
    @pulse_average = @patient.pulse_average

    @reading = @patient.readings.new
    @chart = @patient.readings_chart
  end
  
  def create
    @patient = Patient.find(params[:patient_id])
    @readings = @patient.readings
    @chart = @patient.readings_chart
    @reading = Reading.create(params[:reading])
    if @reading.save
      redirect_to patient_readings_path(@patient), notice: "Reading successfully entered!"
    else
      flash.now.alert = "There was an error with your entry. Please check and try again"
      render :index
    end
  end
end
