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

ActiveRecord::Schema[7.0].define(version: 2023_06_18_174734) do
  create_table "cities", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "job_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "country"
    t.index ["name"], name: "index_cities_on_name", unique: true
  end

  create_table "industries", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "job_count"
    t.index ["name"], name: "index_industries_on_name", unique: true
  end

  create_table "jobs", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "benefit"
    t.string "company_address"
    t.string "company_district"
    t.string "company_name"
    t.text "description"
    t.text "level"
    t.string "name"
    t.text "requirement"
    t.text "salary"
    t.text "type_work"
    t.string "contact_email"
    t.string "contact_name"
    t.string "contact_phone"
    t.integer "industry_id"
    t.integer "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "work_place"
    t.string "company_id"
  end

end
