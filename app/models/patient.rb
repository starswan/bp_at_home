class Patient < ActiveRecord::Base
  belongs_to :doctor
  has_many :readings, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
end
