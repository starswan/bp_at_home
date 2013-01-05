# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130105195355) do

  create_table "doctors", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "practice"
    t.string   "name"
  end

  create_table "patients", :force => true do |t|
    t.integer  "doctor_id"
    t.string   "identifier"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "patients", ["doctor_id"], :name => "index_patients_on_doctor_id"

  create_table "readings", :force => true do |t|
    t.integer  "systolic"
    t.integer  "diastolic"
    t.integer  "pulse"
    t.integer  "patient_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "arm"
  end

  add_index "readings", ["patient_id"], :name => "index_readings_on_patient_id"

end
