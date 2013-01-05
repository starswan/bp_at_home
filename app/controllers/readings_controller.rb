class ReadingsController < ApplicationController

  def index
    @patient = Patient.find(params[:patient_id])
    @reading = @patient.readings.new
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
