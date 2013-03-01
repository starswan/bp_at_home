class Doctor < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :name, :practice, :auth_token
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
end
