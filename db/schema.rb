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

ActiveRecord::Schema[7.0].define(version: 2023_11_30_111909) do
  create_table "attendants", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "parking_lot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.string "razorpayOrderId"
    t.string "razorpaySignature"
    t.string "razorpayPaymentId"
    t.string "parking_lot_id"
    t.string "price"
    t.string "phone"
    t.string "email"
    t.string "name"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "consumers", force: :cascade do |t|
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "owners", force: :cascade do |t|
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parking_lots", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "country"
    t.string "state"
    t.string "city"
    t.string "address"
    t.integer "parking_lot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "total_capacity"
    t.string "price"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
