class Patient < ActiveRecord::Base
  attr_accessible :identifier

  belongs_to :doctor
  has_many :readings

  def sys_average(array=[])
    if readings.count < 1
      return "0"
    else
      readings.each { |r| array << r.systolic }
      return array.inject { |sum, el| sum + el } / array.size
    end
  end

  def dys_average(array=[])
    if readings.count < 1
      return "0"
    else
      readings.each { |r| array << r.diastolic }
      return array.inject { |sum, el| sum + el } / array.size
    end
  end

  def pulse_average(array=[])
    if readings.count < 1
      return "0"
    else
      readings.each { |r| array << r.pulse }
      return array.inject { |sum, el| sum + el } / array.size
    end
  end

end
