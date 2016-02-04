class ApiReadingsController < ApplicationController
  def create
    patientId = params[:patient_id]
    patient = Patient.find_by_identifier(patientId)

    if patient.present?
      systolic = params[:sys]
      diastolic = params[:dia]
      date = Date.parse(params[:date]) rescue nil
      time = Time.parse(params[:time]) rescue params[:time]

      reading = patient.readings.create systolic: systolic, diastolic: diastolic, created_at: date, time: time
      dbstatus = reading.save
      
      if dbstatus
        render :json => {"success" => "success"}
      else
        model_error(reading.errors.messages)
      end
    else
      render :json => {}, status: 404
    end
  end
private
  def model_error errors
    front_end = {}
    errors.each do |k, v|
      front_end[k] = v.join(' and ')
    end
    render :json => front_end , :status => 400
  end
end
