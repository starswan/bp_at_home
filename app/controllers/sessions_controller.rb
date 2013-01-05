class SessionsController < ApplicationController
  def new
  end

  def create
    doctor = Doctor.find_by_email(params[:email])
    if doctor && doctor.authenticate(params[:password])
      session[:doctor_id] = doctor.id
      redirect_to doctor_patients_path(doctor), notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid!"
      render 'pages/home'
    end
  end

  def destroy
    session[:doctor_id] = nil
    redirect_to root_url, notice: 'Logged out'
  end

end
