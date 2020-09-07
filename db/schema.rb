# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_03_102826) do

  create_table "devices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "mac"
    t.string "token"
    t.integer "store_id"
    t.boolean "test_mode"
    t.string "note"
    t.datetime "last_report_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["store_id"], name: "index_devices_on_store_id"
  end

  create_table "stores", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "city_id"
    t.integer "area_id"
    t.integer "contact_name"
    t.integer "contact_phone_number"
    t.integer "devices_count"
    t.string "email"
    t.string "commission"
    t.integer "gender", limit: 2
    t.integer "contract_attachment"
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["area_id"], name: "index_stores_on_area_id"
    t.index ["city_id"], name: "index_stores_on_city_id"
    t.index ["gender"], name: "index_stores_on_gender"
  end

end
