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

ActiveRecord::Schema.define(version: 2020_09_09_064554) do

  create_table "age_group_stores", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "age_group_id"
    t.integer "store_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["age_group_id"], name: "index_age_group_stores_on_age_group_id"
    t.index ["store_id"], name: "index_age_group_stores_on_store_id"
  end

  create_table "age_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "group"
  end

  create_table "areas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.integer "city_id"
    t.integer "zip_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "available"
  end

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

  create_table "store_business_hours", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "day", limit: 2
    t.boolean "is_openness"
    t.time "start_time"
    t.time "end_time"
    t.integer "store_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["is_openness"], name: "index_store_business_hours_on_is_openness"
    t.index ["store_id"], name: "index_store_business_hours_on_store_id"
  end

  create_table "store_introduction_menus", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "store_id"
    t.integer "menu_type", limit: 2
    t.string "attachment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["menu_type"], name: "index_store_introduction_menus_on_menu_type"
    t.index ["store_id"], name: "index_store_introduction_menus_on_store_id"
  end

  create_table "store_introductions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stores", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "city_id"
    t.integer "area_id"
    t.string "contact_name"
    t.string "contact_phone_number"
    t.integer "devices_count"
    t.string "email"
    t.integer "commission"
    t.integer "gender", limit: 2
    t.integer "contract_attachment"
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_information_menu_on"
    t.boolean "is_service_menu_on"
    t.string "inforcharge_menu_alias"
    t.string "service_menu_alias"
    t.string "inforcharge_menu_icon"
    t.string "service_menu_icon"
    t.index ["area_id"], name: "index_stores_on_area_id"
    t.index ["city_id"], name: "index_stores_on_city_id"
    t.index ["gender"], name: "index_stores_on_gender"
  end

end
