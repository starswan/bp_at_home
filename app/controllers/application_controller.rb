class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private

  def current_user
    @current_user ||= Doctor.find(session[:doctor_id]) if session[:doctor_id]
  end
  helper_method :current_user

  def authorize
    redirect_to root_url, alert: 'Not authorized' if current_user.nil?
  end

end
