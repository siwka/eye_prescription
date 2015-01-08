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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150107185800) do

  create_table "prescriptions", force: true do |t|
    t.boolean  "glasses"
    t.string   "re_indicator"
    t.float    "re_value"
    t.string   "le_indicator"
    t.float    "le_value"
    t.string   "re_indicator_extra"
    t.float    "re_value_extra"
    t.string   "le_indicator_extra"
    t.float    "le_value_extra"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "prescriptions", ["user_id", "created_at"], name: "index_prescriptions_on_user_id_and_created_at"
  add_index "prescriptions", ["user_id"], name: "index_prescriptions_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
