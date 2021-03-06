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

ActiveRecord::Schema.define(version: 20170418171858) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hospital_subjects", force: :cascade do |t|
    t.integer  "hospital_id"
    t.integer  "subject_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["hospital_id"], name: "index_hospital_subjects_on_hospital_id", using: :btree
    t.index ["subject_id"], name: "index_hospital_subjects_on_subject_id", using: :btree
  end

  create_table "hospitals", force: :cascade do |t|
    t.string   "number"
    t.string   "name"
    t.string   "zip_code"
    t.string   "address"
    t.string   "orgin_subject"
    t.string   "saikei"
    t.string   "niji"
    t.string   "phone_number"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "orgin_address"
    t.integer  "jurisdiction_id"
    t.index ["number"], name: "index_hospitals_on_number", unique: true, using: :btree
  end

  create_table "jurisdictions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "roman"
    t.index ["name"], name: "index_jurisdictions_on_name", unique: true, using: :btree
    t.index ["roman"], name: "index_jurisdictions_on_roman", unique: true, using: :btree
  end

  create_table "stations", force: :cascade do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_stations_on_name", unique: true, using: :btree
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_subjects_on_code", unique: true, using: :btree
    t.index ["name"], name: "index_subjects_on_name", unique: true, using: :btree
  end

  add_foreign_key "hospital_subjects", "hospitals"
  add_foreign_key "hospital_subjects", "subjects"
end
