class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:query] == 'patient'
      patient = Patient.find_by_identifier(params[:identifier])
      if patient
        session[:patient_id] = patient.id
        redirect_to patient_readings_path(patient), notice: "Congratulations. You are logged in."
      else
        flash.now.alert = "Sorry we could not find that identifier"
        render 'pages/home'
      end
    else
      doctor = Doctor.find_by_email(params[:email])
      if doctor && doctor.authenticate(params[:password])
        session[:doctor_id] = doctor.id
        redirect_to doctor_patients_path(doctor), notice: "Congratulations. You are logged in."
      else
        flash.now.alert = "Email or password is invalid!"
        render 'pages/home'
      end
    end
  end

  def destroy
    session[:doctor_id] = nil
    session[:patient_id] = nil
    redirect_to root_url, notice: 'Logged out'
  end

end
