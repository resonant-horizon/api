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

ActiveRecord::Schema.define(version: 2021_08_09_133730) do

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

  create_table "contacts", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone_number", null: false
    t.string "email", null: false
    t.string "description"
    t.string "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "contactable_type"
    t.bigint "contactable_id"
    t.boolean "is_permanent_party", default: true
    t.bigint "organization_id", null: false
    t.index ["contactable_type", "contactable_id"], name: "index_contacts_on_contactable"
    t.index ["organization_id"], name: "index_contacts_on_organization_id"
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

  create_table "event_employees", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_event_employees_on_employee_id"
    t.index ["event_id"], name: "index_event_employees_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.string "notes"
    t.bigint "service_day_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "location"
    t.index ["service_day_id"], name: "index_events_on_service_day_id"
  end

  create_table "flights", force: :cascade do |t|
    t.integer "airline_network", null: false
    t.integer "airline", null: false
    t.string "flight_number", null: false
    t.datetime "departure_time", null: false
    t.string "departure_airport", null: false
    t.datetime "arrival_time", null: false
    t.string "arrival_airport", null: false
    t.boolean "is_international", default: false
    t.bigint "service_day_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_day_id"], name: "index_flights_on_service_day_id"
  end

  create_table "hotels", force: :cascade do |t|
    t.string "name", null: false
    t.string "street", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip", null: false
    t.string "country", null: false
    t.string "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_hotels_on_organization_id"
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

  create_table "passengers", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "flight_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "locator", null: false
    t.index ["employee_id"], name: "index_passengers_on_employee_id"
    t.index ["flight_id"], name: "index_passengers_on_flight_id"
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

  create_table "season_employees", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "season_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_season_employees_on_employee_id"
    t.index ["season_id"], name: "index_season_employees_on_season_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "name", null: false
    t.string "description"
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_archived", default: false
    t.index ["organization_id"], name: "index_seasons_on_organization_id"
  end

  create_table "service_days", force: :cascade do |t|
    t.string "workable_type"
    t.bigint "workable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "description"
    t.boolean "has_travel", default: false
    t.date "date", null: false
    t.boolean "has_rehearsal", default: false
    t.boolean "has_concert", default: false
    t.boolean "has_loadin", default: false
    t.boolean "has_loadout", default: false
    t.index ["workable_type", "workable_id"], name: "index_service_days_on_workable"
  end

  create_table "service_employees", force: :cascade do |t|
    t.bigint "service_day_id", null: false
    t.bigint "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_service_employees_on_employee_id"
    t.index ["service_day_id"], name: "index_service_employees_on_service_day_id"
  end

  create_table "service_hotels", force: :cascade do |t|
    t.bigint "hotel_id", null: false
    t.bigint "service_day_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["hotel_id"], name: "index_service_hotels_on_hotel_id"
    t.index ["service_day_id"], name: "index_service_hotels_on_service_day_id"
  end

  create_table "service_venues", force: :cascade do |t|
    t.bigint "service_day_id", null: false
    t.bigint "venue_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_day_id"], name: "index_service_venues_on_service_day_id"
    t.index ["venue_id"], name: "index_service_venues_on_venue_id"
  end

  create_table "tour_employees", force: :cascade do |t|
    t.bigint "tour_id", null: false
    t.bigint "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_tour_employees_on_employee_id"
    t.index ["tour_id"], name: "index_tour_employees_on_tour_id"
  end

  create_table "tours", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "name", null: false
    t.string "description"
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.boolean "is_archived", default: false
    t.boolean "is_international", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_tours_on_organization_id"
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

  create_table "venues", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
    t.string "street", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip", null: false
    t.string "country", null: false
    t.integer "capacity"
    t.bigint "organization_id", null: false
    t.boolean "is_headquarters", default: false
    t.index ["organization_id"], name: "index_venues_on_organization_id"
  end

  add_foreign_key "biographies", "employees"
  add_foreign_key "contacts", "organizations"
  add_foreign_key "employee_roles", "employees"
  add_foreign_key "employee_roles", "roles"
  add_foreign_key "employees", "organizations"
  add_foreign_key "employees", "users"
  add_foreign_key "event_employees", "employees"
  add_foreign_key "event_employees", "events"
  add_foreign_key "events", "service_days"
  add_foreign_key "flights", "service_days"
  add_foreign_key "hotels", "organizations"
  add_foreign_key "organizations", "users"
  add_foreign_key "passengers", "employees"
  add_foreign_key "passengers", "flights"
  add_foreign_key "passports", "employees"
  add_foreign_key "season_employees", "employees"
  add_foreign_key "season_employees", "seasons"
  add_foreign_key "seasons", "organizations"
  add_foreign_key "service_employees", "employees"
  add_foreign_key "service_employees", "service_days"
  add_foreign_key "service_hotels", "hotels"
  add_foreign_key "service_hotels", "service_days"
  add_foreign_key "service_venues", "service_days"
  add_foreign_key "service_venues", "venues"
  add_foreign_key "tour_employees", "employees"
  add_foreign_key "tour_employees", "tours"
  add_foreign_key "tours", "organizations"
  add_foreign_key "travelers", "employees"
  add_foreign_key "venues", "organizations"
end
