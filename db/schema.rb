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

ActiveRecord::Schema[7.2].define(version: 2024_08_21_120427) do
  create_table "orders", force: :cascade do |t|
    t.integer "order_id"
    t.integer "location_id"
    t.integer "company_id"
    t.string "delivery_method"
    t.text "notes"
    t.string "dispatched_consignment_note"
    t.boolean "dispatched"
    t.string "delivery_address1"
    t.string "delivery_address2"
    t.string "delivery_suburb"
    t.string "delivery_state"
    t.string "delivery_postcode"
    t.string "delivery_country"
    t.text "delivery_notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access_token"
    t.string "client"
    t.integer "expiry"
  end
end
