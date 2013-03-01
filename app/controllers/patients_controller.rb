class PatientsController < ApplicationController
  before_filter :authorize_doctor!

  def index
   @doctor = Doctor.find(params[:doctor_id])
   @patients = @doctor.patients
  end

  def show
    @patient = Patient.find(params[:id])

    if params[:from] && params[:to]
      @readings = @patient.readings.where(:created_at => params[:from]..params[:to]).order(:created_at)
      calculate_averages_from_averages
    else
      @readings = @patient.readings.order(:created_at)
      calculate_averages_from_averages
    end

    @reading = @patient.readings.new
    render 'readings/index'
  end

  def create
    @doctor = Doctor.find(params[:doctor_id])
    identifier = generate_random_identifier
    patient = @doctor.patients.create(identifier: identifier)
    if patient.save
      redirect_to doctor_patients_path(@doctor), notice: "Patient successfully added. You can now give them their unique identifier. Be sure to record it in the patient record as well."
    else
      flash.now.alert = "Something went wrong. Please try again"
      render :index
    end
  end

  private

    def generate_random_identifier
      o = [('a'..'z'),('A'..'Z')].map { |i| i.to_a }.flatten
      string = (0...6).map{ o[rand(o.length)] }.join
      return string
    end

    def calculate_averages_from_averages
      @sys_average = @readings.average(:systolic)
      @dys_average = @readings.average(:diastolic)
      @pulse_average = @readings.average(:pulse)
    end
end
