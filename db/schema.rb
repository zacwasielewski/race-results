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

ActiveRecord::Schema.define(version: 20141104015020) do

  create_table "races", force: true do |t|
    t.string   "name"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "runners", force: true do |t|
    t.integer  "race_id"
    t.string   "name"
    t.integer  "place"
    t.string   "sex"
    t.integer  "place_in_sex"
    t.string   "age_group"
    t.integer  "total_in_age_group"
    t.integer  "place_in_age_group"
    t.time     "gun_time"
    t.time     "gun_pace"
    t.time     "net_time"
    t.time     "net_pace"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
