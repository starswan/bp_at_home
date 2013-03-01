class Doctor < ActiveRecord::Base
  attr_accessible :name, :email, :practice, :password, :password_confirmation
  has_secure_password
  validates :name, :email, :practice, presence: true
  validates_uniqueness_of :email
  before_create { generate_token(:auth_token) }
  has_many :patients

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Doctor.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    DoctorMailer.password_reset(self).deliver
  end

end
