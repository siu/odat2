# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090412161141) do

  create_table "centers", :force => true do |t|
    t.string   "name",       :limit => 50, :null => false
    t.integer  "region_id",                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "civil_states", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consultation_causes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diagnosis_items", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "description_html"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diagnosis_items_odat_diagnoses", :id => false, :force => true do |t|
    t.integer "diagnosis_item_id", :null => false
    t.integer "odat_diagnosis_id", :null => false
  end

  create_table "formation_levels", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_diagnosticos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_statuses", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_records", :force => true do |t|
    t.integer  "center_id",                                                  :null => false
    t.string   "name",                      :limit => 25,                    :null => false
    t.string   "surname",                   :limit => 50,                    :null => false
    t.date     "birth_date"
    t.date     "archive_date"
    t.string   "city",                      :limit => 40
    t.string   "address",                   :limit => 60
    t.integer  "birth_position",            :limit => 2
    t.string   "gender",                    :limit => 9
    t.string   "father_name",               :limit => 25
    t.string   "father_surname",            :limit => 50
    t.date     "father_birth_date"
    t.integer  "father_job_id"
    t.integer  "father_civil_state_id"
    t.integer  "father_job_status_id"
    t.integer  "father_formation_level_id"
    t.string   "father_email",              :limit => 30
    t.text     "father_extra_information"
    t.string   "mother_name",               :limit => 25
    t.string   "mother_surname",            :limit => 50
    t.date     "mother_birth_date"
    t.integer  "mother_job_id"
    t.integer  "mother_civil_state_id"
    t.integer  "mother_job_status_id"
    t.integer  "mother_formation_level_id"
    t.string   "mother_email",              :limit => 30
    t.text     "mother_extra_information"
    t.string   "home_phone",                :limit => 9
    t.string   "portable_phone",            :limit => 9
    t.string   "work_phone",                :limit => 9
    t.integer  "total_siblings_amount",     :limit => 6
    t.string   "postal",                    :limit => 5
    t.boolean  "sanitary_services"
    t.boolean  "social_services"
    t.boolean  "educative_services"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "multiple_birth",                          :default => false, :null => false
    t.integer  "province_id"
  end

  create_table "odat_diagnoses", :force => true do |t|
    t.integer  "medical_record_id"
    t.integer  "origin_source_id"
    t.integer  "origin_cause_id"
    t.integer  "consultation_cause_id"
    t.integer  "handicap_value"
    t.integer  "main_diagnosis_item_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "origin_causes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "origin_sources", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provinces", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.string   "name",       :limit => 40, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", :force => true do |t|
    t.boolean  "show_signature",                :default => true
    t.string   "signature",      :limit => 150
    t.boolean  "show_signed_on",                :default => true
    t.datetime "signed_on"
    t.integer  "font_size",                     :default => 0
    t.string   "font_family",    :limit => 150
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
    t.string   "type",                                     :default => "User",    :null => false
    t.integer  "center_id"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
