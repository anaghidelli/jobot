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
# It's strongly recommended that you check this file into your version control system.

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 2019_06_04_114422) do
=======
ActiveRecord::Schema.define(version: 2019_05_31_152844) do
>>>>>>> cda0b318de286e615c710f7ec0c17d58214f860c

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.integer "number_of_employees"
    t.string "company_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "logo"
  end

  create_table "company_industries", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "industry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_company_industries_on_company_id"
    t.index ["industry_id"], name: "index_company_industries_on_industry_id"
  end

  create_table "guest_users", force: :cascade do |t|
    t.string "name"
    t.string "job_title"
    t.string "location"
    t.string "total_compensation"
    t.string "years_experience"
    t.string "education_degree"
    t.boolean "visa_sponsor", default: false
    t.boolean "date_posted"
    t.string "employment_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_languages", force: :cascade do |t|
    t.bigint "job_id"
    t.bigint "language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_languages_on_job_id"
    t.index ["language_id"], name: "index_job_languages_on_language_id"
  end

  create_table "job_skills", force: :cascade do |t|
    t.bigint "skill_id"
    t.bigint "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_skills_on_job_id"
    t.index ["skill_id"], name: "index_job_skills_on_skill_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.text "description"
    t.string "job_title"
    t.string "location"
    t.string "total_compensation"
    t.string "years_experience"
    t.string "education_degree"
    t.boolean "visa_sponsor", default: false
    t.date "date_posted"
    t.string "employment_type"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.index ["company_id"], name: "index_jobs_on_company_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "saved_jobs", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "guest_user_id"
    t.index ["guest_user_id"], name: "index_saved_jobs_on_guest_user_id"
    t.index ["job_id"], name: "index_saved_jobs_on_job_id"
    t.index ["user_id"], name: "index_saved_jobs_on_user_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_industries", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "industry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "guest_user_id"
    t.index ["guest_user_id"], name: "index_user_industries_on_guest_user_id"
    t.index ["industry_id"], name: "index_user_industries_on_industry_id"
    t.index ["user_id"], name: "index_user_industries_on_user_id"
  end

  create_table "user_languages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "guest_user_id"
    t.index ["guest_user_id"], name: "index_user_languages_on_guest_user_id"
    t.index ["language_id"], name: "index_user_languages_on_language_id"
    t.index ["user_id"], name: "index_user_languages_on_user_id"
  end

  create_table "user_skills", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "guest_user_id"
    t.index ["guest_user_id"], name: "index_user_skills_on_guest_user_id"
    t.index ["skill_id"], name: "index_user_skills_on_skill_id"
    t.index ["user_id"], name: "index_user_skills_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "job_title"
    t.string "location"
    t.string "total_compensation"
    t.string "years_experience"
    t.string "education_degree"
    t.boolean "visa_sponsor", default: false
    t.boolean "date_posted"
    t.string "employment_type"
    t.string "provider"
    t.string "uid"
    t.string "linkedin_profile_picture"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "company_industries", "companies"
  add_foreign_key "company_industries", "industries"
  add_foreign_key "job_languages", "jobs"
  add_foreign_key "job_languages", "languages"
  add_foreign_key "job_skills", "jobs"
  add_foreign_key "job_skills", "skills"
  add_foreign_key "jobs", "companies"
  add_foreign_key "saved_jobs", "guest_users"
  add_foreign_key "saved_jobs", "jobs"
  add_foreign_key "saved_jobs", "users"
  add_foreign_key "user_industries", "guest_users"
  add_foreign_key "user_industries", "industries"
  add_foreign_key "user_industries", "users"
  add_foreign_key "user_languages", "guest_users"
  add_foreign_key "user_languages", "languages"
  add_foreign_key "user_languages", "users"
  add_foreign_key "user_skills", "guest_users"
  add_foreign_key "user_skills", "skills"
  add_foreign_key "user_skills", "users"
end
