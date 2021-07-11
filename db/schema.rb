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

ActiveRecord::Schema.define(version: 2021_07_10_180029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "biographies", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "full_legal_name"
    t.string "phone_number"
    t.string "email"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "ssn"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "employee_id", null: false
    t.index ["employee_id"], name: "index_biographies_on_employee_id"
  end

  create_table "employee_roles", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_employee_roles_on_employee_id"
    t.index ["role_id"], name: "index_employee_roles_on_role_id"
  end

  create_table "employees", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.boolean "substitute", default: false
    t.boolean "union_designee", default: false
    t.boolean "archived", default: false
    t.integer "instrument_section", null: false
    t.integer "employment_status", null: false
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

  create_table "passports", force: :cascade do |t|
    t.string "passport_number"
    t.string "surname"
    t.string "given_names"
    t.string "nationality"
    t.string "birth_place"
    t.date "birthdate"
    t.date "expiration_date"
    t.date "issue_date"
    t.integer "passport_sex"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "employee_id", null: false
    t.index ["employee_id"], name: "index_passports_on_employee_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "travelers", force: :cascade do |t|
    t.string "delta_ff"
    t.string "american_ff"
    t.string "united_ff"
    t.string "lufthansa_ff"
    t.string "british_air_ff"
    t.integer "seat_preference"
    t.bigint "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_travelers_on_employee_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone_number", null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "biographies", "employees"
  add_foreign_key "employee_roles", "employees"
  add_foreign_key "employee_roles", "roles"
  add_foreign_key "employees", "organizations"
  add_foreign_key "employees", "users"
  add_foreign_key "organizations", "users"
  add_foreign_key "passports", "employees"
  add_foreign_key "travelers", "employees"
end
