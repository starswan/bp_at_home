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
    else
      @readings = @patient.readings.order(:created_at)
    end
    calculate_averages_from_averages

    @reading = @patient.readings.new
  end

  def create
    @doctor = Doctor.find(params[:doctor_id])
    identifier = generate_random_identifier
    patient = @doctor.patients.create(identifier: identifier)
    if patient.save
      redirect_to doctor_patients_path(@doctor), notice: "Patient successfully added. You can now give them their unique identifier which they can use to login. Be sure to record it in the patient record as well."
    else
      flash.now.alert = "Something went wrong. Please try again"
      render :index
    end
  end

  def destroy
    patient = Patient.find(params[:id])
    patient.destroy
    redirect_to doctor_patients_path(current_doctor), notice: "Patient successfully removed."
  end

private

  def generate_random_identifier
    o = [('a'..'z'),('A'..'Z')].map { |i| i.to_a }.flatten
    (0...6).map{ o[rand(o.length)] }.join
  end

  def calculate_averages_from_averages
    averages = Reading.averages @readings
    @sys_average = averages.systolic
    @dys_average = averages.diastolic
  end
end
