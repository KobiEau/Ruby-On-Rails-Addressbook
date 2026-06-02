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

ActiveRecord::Schema[8.1].define(version: 2026_06_01_004908) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string "category", default: "uncategorised"
    t.datetime "created_at", null: false
    t.string "firstname"
    t.string "lastname"
    t.string "phone_number"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["firstname", "lastname", "phone_number", "user_id"], name: "index_contacts_on_name_and_phone_and_user", unique: true
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "error_logs", force: :cascade do |t|
    t.text "backtrace", default: [], array: true
    t.datetime "created_at", null: false
    t.string "error_class", null: false
    t.string "http_method"
    t.string "ip_address"
    t.datetime "last_occurred_at"
    t.text "message", null: false
    t.integer "occurrences", default: 1, null: false
    t.string "path"
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["created_at"], name: "index_error_logs_on_created_at"
    t.index ["error_class"], name: "index_error_logs_on_error_class"
    t.index ["user_id"], name: "index_error_logs_on_user_id"
  end

  create_table "roles", primary_key: "code", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "confirmation_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.datetime "current_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "failed_attempts"
    t.string "firstname"
    t.datetime "last_sign_in_at"
    t.string "last_sign_in_ip"
    t.string "lastname"
    t.datetime "locked_at"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role_code", default: "usr", null: false
    t.integer "sign_in_count", default: 0
    t.string "unconfirmed_email"
    t.string "unlock_token"
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_code"], name: "index_users_on_role_code"
  end

  add_foreign_key "contacts", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "users", "roles", column: "role_code", primary_key: "code"
end
