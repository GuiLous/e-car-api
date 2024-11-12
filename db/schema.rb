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

ActiveRecord::Schema[7.2].define(version: 2024_11_12_161429) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assistant_services", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.integer "price", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assistant_id"
    t.index ["assistant_id"], name: "index_assistant_services_on_assistant_id"
    t.index ["service_id"], name: "index_assistant_services_on_service_id"
  end

  create_table "assistants", force: :cascade do |t|
    t.string "nickname"
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_assistants_on_user_id"
  end

  create_table "hired_services", force: :cascade do |t|
    t.date "schedule_date", null: false
    t.integer "status", default: 0, null: false
    t.bigint "assistant_service_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assistant_service_id"], name: "index_hired_services_on_assistant_service_id"
    t.index ["user_id"], name: "index_hired_services_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "assistant_services", "assistants"
  add_foreign_key "assistant_services", "services"
  add_foreign_key "assistants", "users"
  add_foreign_key "hired_services", "assistant_services"
  add_foreign_key "hired_services", "users"
end
