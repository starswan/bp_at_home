class ReadingsController < ApplicationController
  before_filter :authorize_patient!

  def index
    @patient = Patient.find(params[:patient_id])

    if params[:from] && params[:to]
      @readings = @patient.readings.where(:created_at => params[:from]..params[:to]).order(:created_at)
      calculate_averages_from_averages
    else
      @readings = @patient.readings.order(:created_at)
      calculate_averages_from_averages
    end

    @reading = @patient.readings.new
  end

  def create
    @patient = Patient.find(params[:patient_id])
    @readings = @patient.readings.order(:created_at)
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
    @readings = @patient.readings.order(:created_at)
    @reading = @patient.readings.new
    render :index
  end

  private

    def calculate_averages_from_averages
      @sys_average = @readings.average(:systolic)
      @dys_average = @readings.average(:diastolic)
      @pulse_average = @readings.average(:pulse)
    end
end
