class Doctor < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :name, :practice
  has_secure_password
  
  validates_uniqueness_of :email
end
