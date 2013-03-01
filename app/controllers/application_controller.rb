class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_doctor
    @current_doctor ||= Doctor.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_doctor

  def current_patient
    @current_patient || Patient.find(session[:patient_id]) if session[:patient_id]
  end
  helper_method :current_patient

  def authorize_doctor!
    redirect_to root_url, alert: 'You are not authorized to view that information. Please login to proceed' if current_doctor.nil?
  end

  def authorize_patient!
    redirect_to root_url, alert: 'You are not authorized to view that information. Please login to proceed' if current_patient.nil?
  end

end
