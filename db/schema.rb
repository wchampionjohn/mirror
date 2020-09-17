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

ActiveRecord::Schema.define(version: 2020_09_16_070752) do

  create_table "ad_age_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "age_group_id"
    t.integer "ad_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ad_id"], name: "index_ad_age_groups_on_ad_id"
    t.index ["age_group_id"], name: "index_ad_age_groups_on_age_group_id"
  end

  create_table "ad_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "ad_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ad_category_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "ad_id"
    t.integer "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ads", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.integer "seconds"
    t.date "start_at"
    t.date "end_at"
    t.string "material"
    t.string "banner"
    t.integer "category_id"
    t.integer "category_item_id"
    t.integer "advertiser_id"
    t.decimal "budget", precision: 10, scale: 2
    t.integer "ad_type", limit: 2
    t.integer "gender", limit: 2
    t.string "scanning_link"
    t.decimal "cpv", precision: 10, scale: 2
    t.decimal "cpm", precision: 10, scale: 2
    t.integer "impressions"
    t.integer "views"
    t.integer "viewers", comment: "可以辨識出人臉數據的觀看者"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "screenshot"
    t.string "material_md5"
    t.integer "material_size"
    t.string "banner_md5"
    t.integer "banner_size"
    t.index ["ad_type"], name: "index_ads_on_ad_type"
    t.index ["end_at"], name: "index_ads_on_end_at"
    t.index ["gender"], name: "index_ads_on_gender"
    t.index ["start_at"], name: "index_ads_on_start_at"
    t.index ["status"], name: "index_ads_on_status"
  end

  create_table "advertisers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

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

  create_table "headquarters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "stores_count"
    t.string "name"
    t.integer "commission"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "store_introductions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "store_id"
    t.integer "menu_type", limit: 2
    t.string "attachment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["store_id"], name: "index_store_introductions_on_store_id"
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
    t.string "information_menu_alias"
    t.string "service_menu_alias"
    t.string "information_menu_icon"
    t.string "service_menu_icon"
    t.integer "headquarter_id"
    t.index ["area_id"], name: "index_stores_on_area_id"
    t.index ["city_id"], name: "index_stores_on_city_id"
    t.index ["gender"], name: "index_stores_on_gender"
    t.index ["headquarter_id"], name: "index_stores_on_headquarter_id"
  end

  create_table "tmp_files", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "file"
    t.string "model"
    t.string "column"
    t.integer "size"
    t.string "md5"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
