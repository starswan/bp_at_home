class ReadingsController < ApplicationController
  before_filter :authorize_patient!

  def index
    @patient = Patient.find(params[:patient_id])
    readings_charts_and_averages
    @reading = @patient.readings.new
  end

  def create
    @patient = Patient.find(params[:patient_id])
    readings_charts_and_averages
    @reading = Reading.create(params[:reading])
    if @reading.save
      redirect_to patient_readings_path(@patient), notice: "Reading successfully entered!"
    else
      flash.now.alert = "There was an error with your entry. Please check and try again"
      render :index
    end
  end

  def export
    @patient = Patient.find(params[:patient_id])
    readings_charts_and_averages
    @reading = @patient.readings.new
    render :index
  end

  private

    def readings_charts_and_averages
      @readings = @patient.readings.order(:created_at)
      @sys_average = @readings.average(:systolic)
      @dys_average = @readings.average(:diastolic)
      @pulse_average = @readings.average(:pulse)
    end
end
