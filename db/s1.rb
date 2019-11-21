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

ActiveRecord::Schema.define(version: 20191113165553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auths", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.string   "role"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  create_table "logins", force: :cascade do |t|
    t.integer  "username"
    t.string   "password"
    t.string   "email"
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "review_id"
    t.bigint   "user_id"
    t.integer  "year"
    t.integer  "review_score"
    t.string   "notes"
    t.string   "comments_for_faculty"
    t.string   "comments_for_student"
    t.datetime "review_open_date"
    t.datetime "review_official_student_deadline"
    t.datetime "review_student_input_date"
    t.datetime "review_faculty_input_date"
    t.datetime "ip_open_date"
    t.datetime "ip_official_student_deadline"
    t.datetime "ip_student_input_date"
    t.datetime "ip_faculty_input_date"
    t.datetime "ip_release_date"
    t.datetime "dp_open_date"
    t.datetime "dp_official_student_deadline"
    t.datetime "dp_student_input_date"
    t.datetime "dp_faculty_input_date"
    t.datetime "dp_release_date"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "searches", id: false, force: :cascade do |t|
    t.integer  "uin"
    t.string   "first_name"
    t.string   "last_name"
    t.decimal  "review_year"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", id: false, force: :cascade do |t|
    t.integer  "uin"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.string   "major"
    t.string   "degree"
    t.string   "review_year"
    t.integer  "cumul_gpa"
    t.datetime "degree_plan_date"
    t.datetime "qual_exam_date"
    t.string   "qual_exam_result"
    t.datetime "prelim_date"
    t.datetime "proposal_date"
    t.datetime "final_exam_defence_date"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
