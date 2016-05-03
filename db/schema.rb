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

ActiveRecord::Schema.define(version: 20160420100047) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address1"
    t.string   "address2"
    t.string   "zipcode"
    t.string   "city"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "phone_number"
    t.integer  "addressable_id"
    t.string   "addressable_type"
  end

  add_index "addresses", ["addressable_id"], name: "index_addresses_on_addressable_id", using: :btree

  create_table "areas", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exceptional_availabilities", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "available_now"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "historical_transitions", force: :cascade do |t|
    t.integer  "historisable_id"
    t.string   "historisable_type"
    t.string   "event"
    t.string   "from"
    t.string   "to"
    t.datetime "processed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "historical_transitions", ["historisable_id"], name: "index_historical_transitions_on_historisable_id", using: :btree

  create_table "intervention_types", force: :cascade do |t|
    t.string   "kind"
    t.string   "short_description"
    t.decimal  "price"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "description"
  end

  create_table "interventions", force: :cascade do |t|
    t.string   "state"
    t.integer  "customer_id"
    t.integer  "contractor_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "intervention_type_id"
    t.decimal  "price"
    t.string   "client_token_ownership"
    t.datetime "assigned_at"
    t.string   "rating"
    t.boolean  "is_ok"
    t.text     "opinion"
    t.string   "payment_method"
  end

  add_index "interventions", ["client_token_ownership"], name: "index_interventions_on_client_token_ownership", unique: true, using: :btree
  add_index "interventions", ["contractor_id"], name: "index_interventions_on_contractor_id", using: :btree
  add_index "interventions", ["customer_id"], name: "index_interventions_on_customer_id", using: :btree
  add_index "interventions", ["intervention_type_id"], name: "index_interventions_on_intervention_type_id", using: :btree

  create_table "user_areas", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_areas", ["area_id"], name: "index_user_areas_on_area_id", using: :btree
  add_index "user_areas", ["user_id", "area_id"], name: "index_user_areas_on_user_id_and_area_id", unique: true, using: :btree
  add_index "user_areas", ["user_id"], name: "index_user_areas_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "role",                                null: false
    t.string   "phone_number"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "firstname"
    t.string   "lastname"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "weekly_availabilities", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "monday_0_4_availability",      default: false
    t.boolean  "tuesday_0_4_availability",     default: false
    t.boolean  "wednesday_0_4_availability",   default: false
    t.boolean  "thursday_0_4_availability",    default: false
    t.boolean  "friday_0_4_availability",      default: false
    t.boolean  "saturday_0_4_availability",    default: false
    t.boolean  "sunday_0_4_availability",      default: false
    t.boolean  "monday_4_8_availability",      default: false
    t.boolean  "tuesday_4_8_availability",     default: false
    t.boolean  "wednesday_4_8_availability",   default: false
    t.boolean  "thursday_4_8_availability",    default: false
    t.boolean  "friday_4_8_availability",      default: false
    t.boolean  "saturday_4_8_availability",    default: false
    t.boolean  "sunday_4_8_availability",      default: false
    t.boolean  "monday_8_12_availability",     default: false
    t.boolean  "tuesday_8_12_availability",    default: false
    t.boolean  "wednesday_8_12_availability",  default: false
    t.boolean  "thursday_8_12_availability",   default: false
    t.boolean  "friday_8_12_availability",     default: false
    t.boolean  "saturday_8_12_availability",   default: false
    t.boolean  "sunday_8_12_availability",     default: false
    t.boolean  "monday_12_16_availability",    default: false
    t.boolean  "tuesday_12_16_availability",   default: false
    t.boolean  "wednesday_12_16_availability", default: false
    t.boolean  "thursday_12_16_availability",  default: false
    t.boolean  "friday_12_16_availability",    default: false
    t.boolean  "saturday_12_16_availability",  default: false
    t.boolean  "sunday_12_16_availability",    default: false
    t.boolean  "monday_16_20_availability",    default: false
    t.boolean  "tuesday_16_20_availability",   default: false
    t.boolean  "wednesday_16_20_availability", default: false
    t.boolean  "thursday_16_20_availability",  default: false
    t.boolean  "friday_16_20_availability",    default: false
    t.boolean  "saturday_16_20_availability",  default: false
    t.boolean  "sunday_16_20_availability",    default: false
    t.boolean  "monday_20_24_availability",    default: false
    t.boolean  "tuesday_20_24_availability",   default: false
    t.boolean  "wednesday_20_24_availability", default: false
    t.boolean  "thursday_20_24_availability",  default: false
    t.boolean  "friday_20_24_availability",    default: false
    t.boolean  "saturday_20_24_availability",  default: false
    t.boolean  "sunday_20_24_availability",    default: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "zip_codes", force: :cascade do |t|
    t.string   "zipcode"
    t.integer  "area_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "zip_codes", ["area_id"], name: "index_zip_codes_on_area_id", using: :btree
  add_index "zip_codes", ["zipcode"], name: "index_zip_codes_on_zipcode", unique: true, using: :btree

  add_foreign_key "zip_codes", "areas"
end
