class PatientsController < ApplicationController
  before_filter :authorize_doctor!

  def index
   @doctor = Doctor.find(params[:doctor_id])
   @patients = @doctor.patients
  end

  def show
    @patient = Patient.find(params[:id])

    # if we have searched by to and from date
    if params[:from] && params[:to]
      from_date = params[:from]
      to_date = params[:to]

      @readings = @patient.readings.where(:created_at => from_date..to_date)
      @sys_average = @patient.sys_average
      @dys_average = @patient.dys_average
      @pulse_average = @patient.pulse_average
    # default
    else
      @readings = @patient.readings.order(:created_at)
      @sys_average = @patient.sys_average
      @dys_average = @patient.dys_average
      @pulse_average = @patient.pulse_average
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
end
