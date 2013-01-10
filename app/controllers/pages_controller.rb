class PagesController < ApplicationController
  def home
    if current_doctor
      redirect_to doctor_patients_path(current_doctor)
    elsif current_patient
      redirect_to patient_readings_path(current_patient)
    end
  end
end
