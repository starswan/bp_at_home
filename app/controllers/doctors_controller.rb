class DoctorsController < ApplicationController

  def new
    @doctor = Doctor.new
  end
  
  def create
    @doctor = Doctor.new(params[:doctor])
    if @doctor.save
      session[:doctor_id] = @doctor.id
      redirect_to root_url, notice: "Thank you for signing up"
    else
      render :new
    end
  end
end
