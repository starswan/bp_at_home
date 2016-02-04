class ReadingsController < ApplicationController
  before_filter :authorize_patient!
  before_filter :find_patient

  def index
    if params[:from] && params[:to]
      @readings = @patient.readings.where(:created_at => params[:from]..params[:to]).order(:created_at)
      calculate_averages_from_averages
    else
      @readings = @patient.readings.order(:created_at)
      calculate_averages_from_averages
    end

    @reading = @patient.readings.new created_at: Date.today
  end

  def create
    @reading = Reading.create(params[:reading])
    if @reading.save
      redirect_to patient_readings_path(@patient), notice: "Reading successfully entered!"
    else
      flash.now.alert = "There was an error with your entry. Please check and try again"
      render :index
    end
  end

  def new
    @reading = @patient.readings.new created_at: Date.today
  end

  def export
    @readings = @patient.readings.order(:created_at)
    calculate_averages_from_averages
    @reading = @patient.readings.new
    render :index
  end

private

  def find_patient
    @patient = Patient.find(params[:patient_id])
  end

  def calculate_averages_from_averages
    averages = Reading.averages @readings
    @sys_average = averages.systolic
    @dys_average = averages.diastolic
  end
end
