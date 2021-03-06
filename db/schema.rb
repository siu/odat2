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

ActiveRecord::Schema.define(:version => 20111002155839) do

  create_table "center_resources", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description_html"
  end

  create_table "center_resources_odat_diagnoses", :id => false, :force => true do |t|
    t.integer "odat_diagnosis_id",  :null => false
    t.integer "center_resource_id", :null => false
  end

  create_table "centers", :force => true do |t|
    t.string   "name",       :limit => 50, :null => false
    t.integer  "region_id",                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "centers", ["name"], :name => "index_centers_on_name"

  create_table "civil_states", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.text     "description_html"
  end

  create_table "comparative_report_field_template_assignments", :force => true do |t|
    t.integer  "position"
    t.string   "name"
    t.string   "group"
    t.integer  "comparative_report_id"
    t.integer  "report_field_template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comparative_report_template_field_assignments", :force => true do |t|
    t.integer  "position"
    t.string   "name"
    t.string   "group"
    t.integer  "comparative_report_template_id"
    t.integer  "report_field_template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comparative_report_templates", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "view_template"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comparative_reports", :force => true do |t|
    t.boolean  "show_signature",                 :default => true
    t.text     "signature"
    t.boolean  "show_signed_on",                 :default => true
    t.datetime "signed_on"
    t.integer  "configurable_view_id"
    t.integer  "center_id"
    t.integer  "comparative_report_template_id"
    t.string   "type",                           :default => "ComparativeReport", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "extra_information"
    t.text     "extra_information_html"
  end

  add_index "comparative_reports", ["center_id"], :name => "index_comparative_reports_on_center_id"

  create_table "configurable_views", :force => true do |t|
    t.integer "font_size"
    t.string  "font_family", :limit => 150
    t.boolean "table_grid"
  end

  create_table "consultation_causes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.text     "description_html"
  end

  create_table "diagnosis_items", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "description_html"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "multiple_select",      :default => true
    t.integer  "classification_level"
  end

  add_index "diagnosis_items", ["parent_id", "lft"], :name => "index_diagnosis_items_on_parent_id_and_lft"
  add_index "diagnosis_items", ["parent_id", "lft"], :name => "index_diagnosis_items_on_parent_id_and_lft_and_position"

  create_table "diagnosis_items_odat_diagnoses", :id => false, :force => true do |t|
    t.integer "diagnosis_item_id", :null => false
    t.integer "odat_diagnosis_id", :null => false
  end

  create_table "formation_levels", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.text     "description_html"
  end

  create_table "individual_reports", :force => true do |t|
    t.integer  "medical_record_id"
    t.integer  "odat_diagnosis_id"
    t.text     "topic"
    t.text     "topic_html"
    t.text     "tests"
    t.text     "tests_html"
    t.text     "results"
    t.text     "results_html"
    t.text     "orientation"
    t.text     "orientation_html"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "signature"
    t.datetime "signed_on"
    t.boolean  "show_signature",                   :default => true
    t.boolean  "show_signed_on",                   :default => true
    t.integer  "configurable_view_id"
    t.boolean  "show_medical_record_archive_date"
    t.boolean  "show_birth_date"
    t.boolean  "show_age"
    t.boolean  "show_full_name"
    t.boolean  "show_gender"
    t.boolean  "show_birth_position"
    t.boolean  "show_address"
    t.boolean  "show_siblings_data"
    t.boolean  "show_father_data"
    t.boolean  "show_mother_data"
    t.boolean  "show_phone_numbers"
    t.boolean  "show_diagnosis_created_at"
    t.boolean  "show_consultation_details"
    t.boolean  "show_center_resources"
    t.boolean  "show_detailed_diagnosis"
    t.boolean  "show_coordination_services"
    t.boolean  "show_main_diagnosis"
    t.text     "extra_information"
    t.text     "extra_information_html"
    t.boolean  "show_handicap_data"
    t.boolean  "show_level3",                      :default => false
  end

  add_index "individual_reports", ["medical_record_id"], :name => "index_individual_reports_on_medical_record_id"

  create_table "job_statuses", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.text     "description_html"
  end

  create_table "jobs", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.text     "description_html"
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
    t.integer  "total_siblings_amount",     :limit => 8
    t.string   "postal",                    :limit => 5
    t.boolean  "sanitary_services"
    t.boolean  "social_services"
    t.boolean  "educative_services"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "multiple_birth",                          :default => false, :null => false
    t.integer  "province_id"
    t.integer  "position_in_siblings"
    t.boolean  "handicap",                                :default => false, :null => false
    t.integer  "dependency_degree"
    t.integer  "school_type_id"
  end

  create_table "odat_diagnoses", :force => true do |t|
    t.integer  "medical_record_id",      :null => false
    t.integer  "origin_source_id",       :null => false
    t.integer  "origin_cause_id",        :null => false
    t.integer  "consultation_cause_id",  :null => false
    t.integer  "main_diagnosis_item_id", :null => false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description_html"
  end

  add_index "odat_diagnoses", ["medical_record_id"], :name => "index_odat_diagnoses_on_medical_record_id"

  create_table "origin_causes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.text     "description_html"
  end

  create_table "origin_sources", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.text     "description_html"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.text     "sidebar_content"
    t.text     "sidebar_content_html"
    t.text     "content"
    t.text     "content_html"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["permalink"], :name => "index_pages_on_permalink"

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

  create_table "report_field_templates", :force => true do |t|
    t.string   "applicable_on"
    t.text     "function"
    t.string   "render_method"
    t.string   "render_options"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",           :default => "unnamed", :null => false
  end

  create_table "reports", :force => true do |t|
    t.boolean  "show_signature",         :default => true
    t.text     "signature"
    t.boolean  "show_signed_on",         :default => true
    t.datetime "signed_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "configurable_view_id"
    t.text     "extra_information"
    t.text     "extra_information_html"
  end

  create_table "school_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "description_html"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",              :limit => 25,                      :null => false
    t.string   "email",                                                 :null => false
    t.string   "crypted_password",   :limit => 128,                     :null => false
    t.string   "password_salt",                                         :null => false
    t.string   "persistence_token",                                     :null => false
    t.string   "perishable_token",                                      :null => false
    t.integer  "login_count",                       :default => 0,      :null => false
    t.integer  "failed_login_count",                :default => 0,      :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.boolean  "active",                            :default => true,   :null => false
    t.boolean  "approved",                          :default => false,  :null => false
    t.boolean  "confirmed",                         :default => false,  :null => false
    t.string   "role",                              :default => "user", :null => false
    t.string   "name",               :limit => 25
    t.integer  "center_id"
  end

  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
