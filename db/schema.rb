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

ActiveRecord::Schema.define(version: 2019_07_17_212820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "task_lists", force: :cascade do |t|
    t.string "title", null: false
    t.boolean "open", default: false, null: false
    t.boolean "favorite", default: false, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_task_lists_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", default: ""
    t.boolean "done", default: false
    t.bigint "task_list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subtask"
    t.index ["task_list_id"], name: "index_tasks_on_task_list_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "task_lists", "users"
  add_foreign_key "tasks", "task_lists"
end
