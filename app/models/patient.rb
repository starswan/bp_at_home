class Patient < ActiveRecord::Base
  attr_accessible :belongs_to, :identifier

  belongs_to :doctor
end
