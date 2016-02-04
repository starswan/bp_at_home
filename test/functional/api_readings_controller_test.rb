require 'test_helper'

class ApiReadingsControllerTest < ActionController::TestCase
  test "post should create a new reading for a patient" do
    assert_difference('Reading.count') do 
      post :create, format: :json, patient_id: '1', sys: 120, dia: 80, date: '2016-01-04', time: '11:00'
    end
    reading =  patients(:one).readings.first
    assert_equal(120,reading.systolic)
    assert_equal(80, reading.diastolic)
    assert_equal(DateTime.parse('2016-01-04'), reading.created_at)
    assert_equal(DateTime.parse('2000-01-01 11:00'), reading.time)
    assert_response :success
  end

  test "should complain if patient identifier does not exist in db" do
    post :create, format: :json, patient_id: 'invalid', sys: 120, dia: 80, date: '2016-01-04', time: '11:00'
    assert_response 404
  end

  test "should complain if there is no systolic reading" do
    post :create, format: :json, patient_id: '1', dia: 80, date: '2016-01-04', time: '11:00'
    assert_response 400
    assert_equal({'systolic' => 'can\'t be blank and is not a number'}, parsed_result)
  end

  test "should complain is systolic reading is too high" do
     post :create, format: :json, patient_id: '1', sys: 241, dia: 80, date: '2016-01-04', time: '11:00'
     assert_response 400
     assert_equal({'systolic' => 'must be less than or equal to 240'}, parsed_result)
  end

  test "should complain is systolic reading is too low" do
     post :create, format: :json, patient_id: '1', sys: 69, dia: 80, date: '2016-01-04', time: '11:00'
     assert_response 400
     assert_equal({'systolic' => 'must be greater than or equal to 70'}, parsed_result)
  end

  test "should complain is there is no diastolic reading" do
     post :create, format: :json, patient_id: '1', sys: 120, date: '2016-01-04', time: '11:00'
     assert_response 400
     assert_equal({'diastolic' => 'can\'t be blank and is not a number'}, parsed_result)
  end

  test "should complain if diastolic is too high" do
     post :create, format: :json, patient_id: '1', sys: 120, dia: 131, date: '2016-01-04', time: '11:00'
     assert_response 400
     assert_equal({'diastolic' => 'must be less than or equal to 130'}, parsed_result)
  end

  test "should complain if diastolic is too low" do
     post :create, format: :json, patient_id: '1', sys: 120, dia: 29, date: '2016-01-04', time: '11:00'
     assert_response 400
     assert_equal({'diastolic' => 'must be greater than or equal to 30'}, parsed_result)
  end

  test "should complain if date is missing" do
    post :create, format: :json, patient_id: '1', sys: 120, dia: 80, time: '11:00'
    assert_response 400
    assert_equal({'created_at' => 'can\'t be blank'}, parsed_result)
  end

  test "should complain if date is invalid" do
    post :create, format: :json, patient_id: '1', sys: 120, dia: 80, date: 'bad date', time: '11:00'
    assert_response 400
    assert_equal({'created_at' => 'can\'t be blank'}, parsed_result)
    # checkErrorMessageIs('Date "bad date" is not in format yyyy-mm-dd')
  end

  test "should not complain if time is missing" do
    assert_difference('Reading.count') do
      post :create, format: :json, patient_id: '1', sys: 120, dia: 80, date: '2016-01-04'
    end
    assert_response 200
  end

  # test "should complain if time is invalid" do
  #    post :create, format: :json, patient_id: '1', sys: 120, dia: 80, date: '2016-01-04', time: 'bad time'
  #    assert_response 400
  #    assert_equal({'created_at' => 'can\'t be blank'}, parsed_result)
  #    # checkErrorMessageIs('Time "bad time" is not in formal hh:mm')
  # end

  test "should complain if there is already a blood pressure entry for that point" do
   # post :create, format: :json, patient_id: '1', sys: 120, dia: 80, date: '2016-01-04', time: '11:00'
  #  assertEqual(120, patients(:one).readings.first.systolic)

   # post :create, format: :json, patient_id: '1', sys: 125, dia: 85, date: '2016-01-04', time: '11:00'
   # assert_equal(1,patients(:one).readings.size)
   # assert_equal(120, patients(:one).readings.first.systolic)
 
    #checkErrorMessageIs('Reading for that date already specified')
  end

  def parsed_result
    JSON.parse(@response.body)
  end
end
