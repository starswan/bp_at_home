class Patient < ActiveRecord::Base
  attr_accessible :identifier

  belongs_to :doctor
  has_many :readings

end
