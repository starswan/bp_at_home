class DoctorsController < ApplicationController
  def new
    @doctor = Doctor.new
  end
  
  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      session[:doctor_id] = @doctor.id
      redirect_to doctors_url, notice: "Thank you for signing up"
    else
      render :new
    end
  end
private
  def doctor_params
    params.require(:doctor).permit(:name, :email, :practice, :password, :password_confirmation)
  end
end
