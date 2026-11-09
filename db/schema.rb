# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_11_03_043328) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.date "work_date"
    t.datetime "signed_in_at"
    t.datetime "signed_off_at"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["work_date"], name: "index_attendances_on_work_date", unique: true
  end

  create_table "break_periods", force: :cascade do |t|
    t.integer "attendance_id", null: false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attendance_id"], name: "index_break_periods_on_attendance_id"
  end

  create_table "pomodoro_sessions", force: :cascade do |t|
    t.string "task_name"
    t.integer "focus_duration"
    t.integer "break_duration"
    t.string "status"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.integer "completed_cycles"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "break_periods", "attendances"
end
