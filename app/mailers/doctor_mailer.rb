class DoctorMailer < ActionMailer::Base
  default from: "ed@podmedics.com"

  def password_reset(doctor)
    @doctor = doctor
    mail to: doctor.email, Subject: "Password reset"
  end
end
