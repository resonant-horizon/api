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

ActiveRecord::Schema.define(version: 2021_07_05_164355) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "email"
    t.string "full_legal_name"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "ssn"
    t.string "passport_number"
    t.date "passport_issue_date"
    t.date "passport_expiration"
    t.date "birthdate"
    t.string "birth_city"
    t.string "nationality"
    t.integer "passport_sex"
    t.string "american_frequent_flyer"
    t.string "delta_frequent_flier"
    t.string "united_frequent_flyer"
    t.bigint "organization_id", null: false
    t.integer "employment_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.integer "instrument_section"
    t.integer "role", default: [], array: true
    t.boolean "substitute", default: false
    t.boolean "union_designee", default: false
    t.boolean "archived", default: false
    t.index ["organization_id"], name: "index_employees_on_organization_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "contact_name", null: false
    t.string "contact_email", null: false
    t.string "phone_number", null: false
    t.string "street_address", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_organizations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone_number", null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "employees", "organizations"
  add_foreign_key "employees", "users"
  add_foreign_key "organizations", "users"
end
