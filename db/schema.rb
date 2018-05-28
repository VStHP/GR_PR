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

ActiveRecord::Schema.define(version: 20180503083518) do

  create_table "answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "text"
    t.integer "correct"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "phone"
    t.string "email"
    t.text "description"
    t.string "image_1"
    t.string "image_2"
    t.string "image_3"
    t.string "image_4"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "course_id"
    t.string "subject_id"
    t.integer "status", default: 0
    t.datetime "date_start"
    t.datetime "date_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "subject_id"], name: "index_course_subjects_on_course_id_and_subject_id", unique: true
    t.index ["course_id"], name: "index_course_subjects_on_course_id"
    t.index ["subject_id"], name: "index_course_subjects_on_subject_id"
  end

  create_table "course_user_lessons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "course_user_id"
    t.bigint "lesson_id"
    t.integer "status", default: 0
    t.datetime "date_start"
    t.datetime "date_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_user_id", "lesson_id"], name: "index_course_user_lessons_on_course_user_id_and_lesson_id", unique: true
    t.index ["course_user_id"], name: "index_course_user_lessons_on_course_user_id"
    t.index ["lesson_id"], name: "index_course_user_lessons_on_lesson_id"
  end

  create_table "course_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "course_id"
    t.bigint "user_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "user_id"], name: "index_course_users_on_course_id_and_user_id", unique: true
    t.index ["course_id"], name: "index_course_users_on_course_id"
    t.index ["user_id"], name: "index_course_users_on_user_id"
  end

  create_table "courses", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.bigint "user_id"
    t.string "program"
    t.string "banner"
    t.string "avatar"
    t.datetime "date_start"
    t.datetime "date_end"
    t.integer "status", default: 0
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "language"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "exam_lessons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float "score", limit: 24
    t.integer "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_user_lesson_id"
    t.index ["course_user_lesson_id"], name: "index_exam_lessons_on_course_user_lesson_id"
  end

  create_table "exam_subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "subject_id"
    t.float "score", limit: 24
    t.integer "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_user_id"
    t.index ["course_user_id"], name: "index_exam_subjects_on_course_user_id"
    t.index ["subject_id"], name: "index_exam_subjects_on_subject_id"
  end

  create_table "lessons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.string "youtube_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subject_id"
    t.integer "test_time"
    t.integer "num_question_test", default: 20
    t.index ["subject_id"], name: "index_lessons_on_subject_id"
  end

  create_table "links", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "link"
    t.text "description"
    t.bigint "lesson_id"
    t.string "subject_id"
    t.string "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_links_on_course_id"
    t.index ["lesson_id"], name: "index_links_on_lesson_id"
    t.index ["subject_id"], name: "index_links_on_subject_id"
  end

  create_table "list_question_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "answer_ids"
    t.integer "chosen_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "exam_subject_id"
    t.bigint "exam_lesson_id"
    t.bigint "question_id"
    t.index ["exam_lesson_id"], name: "index_list_question_answers_on_exam_lesson_id"
    t.index ["exam_subject_id"], name: "index_list_question_answers_on_exam_subject_id"
    t.index ["question_id"], name: "index_list_question_answers_on_question_id"
  end

  create_table "questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "lesson_id"
    t.index ["lesson_id"], name: "index_questions_on_lesson_id"
  end

  create_table "registrations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "position"
    t.text "message"
    t.string "cv_url"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.integer "phone"
    t.string "position"
    t.string "message"
    t.text "cv_url"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "day_on_learn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.string "avatar"
    t.integer "test_time"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "gender"
    t.date "birthday"
    t.string "phone"
    t.string "university"
    t.string "program"
    t.string "avatar"
    t.integer "permission", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "course_subjects", "courses"
  add_foreign_key "course_subjects", "subjects"
  add_foreign_key "course_user_lessons", "course_users", on_delete: :cascade
  add_foreign_key "course_user_lessons", "lessons", on_delete: :cascade
  add_foreign_key "course_users", "courses"
  add_foreign_key "course_users", "users"
  add_foreign_key "courses", "users"
  add_foreign_key "exam_lessons", "course_user_lessons"
  add_foreign_key "exam_subjects", "course_users"
  add_foreign_key "exam_subjects", "subjects"
  add_foreign_key "lessons", "subjects"
  add_foreign_key "links", "courses"
  add_foreign_key "links", "lessons"
  add_foreign_key "links", "subjects"
  add_foreign_key "list_question_answers", "exam_lessons"
  add_foreign_key "list_question_answers", "exam_subjects"
  add_foreign_key "list_question_answers", "questions"
  add_foreign_key "questions", "lessons"
end
