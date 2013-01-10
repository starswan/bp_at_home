class PatientsController < ApplicationController
  before_filter :authorize_doctor!

  def index
   @doctor = Doctor.find(params[:doctor_id]) 
   @patients = @doctor.patients
  end

  def show
    @patient = Patient.find(params[:id]) 
    @readings = @patient.readings.order(:created_at)
    @sys_average = @patient.sys_average
    @dys_average = @patient.dys_average
    @pulse_average = @patient.pulse_average
    @chart = @patient.readings_chart
    
    @reading = @patient.readings.new
    render 'readings/index'
  end

  def create
    @doctor = Doctor.find(params[:doctor_id])
    identifier = generate_random_identifier
    patient = @doctor.patients.create(identifier: identifier)
    if patient.save
      redirect_to doctor_patients_path(@doctor), notice: "Patient successfully added. You can now give them their unique identifier. Be sure to record it in the notes as well."
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
end
