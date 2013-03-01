class PasswordResetsController < ApplicationController
  def create
    doctor = Doctor.find_by_email(params[:email])
    doctor.send_password_reset if doctor
    redirect_to root_url, notice: "Email sent with password reset instructions."
  end

  def edit
    @doctor = Doctor.find_by_password_reset_token!(params[:id])
  end

  def update
    @doctor = Doctor.find_by_password_reset_token!(params[:id])
    if @doctor.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @doctor.update_attributes(params[:doctor])
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end


end
