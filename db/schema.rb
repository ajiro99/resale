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

ActiveRecord::Schema.define(version: 2019_03_01_444537) do

  create_table "extras", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.boolean "display"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "type"
    t.integer "maker"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remarks"
  end

  create_table "sale_extras", force: :cascade do |t|
    t.integer "sale_id"
    t.integer "extra_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["extra_id"], name: "index_sale_extras_on_extra_id"
    t.index ["sale_id"], name: "index_sale_extras_on_sale_id"
  end

  create_table "sales", force: :cascade do |t|
    t.date "sales_date"
    t.integer "product_type"
    t.integer "stocking_price", default: 0
    t.integer "bonus_price", default: 0
    t.integer "cost", default: 0
    t.integer "selling_price"
    t.integer "fee", default: 0
    t.integer "shipping_type"
    t.integer "shipping_cost", default: 0
    t.integer "sales", default: 0
    t.integer "profit", default: 0
    t.decimal "profit_rate", precision: 5, scale: 2
    t.integer "state"
    t.integer "account"
    t.integer "sales_channel"
    t.string "remarks"
    t.string "product_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocking_products", force: :cascade do |t|
    t.integer "stocking_id"
    t.integer "product_id"
    t.integer "sale_id"
    t.integer "estimated_price", default: 0
    t.integer "color"
    t.boolean "janck"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_stocking_products_on_product_id"
    t.index ["sale_id"], name: "index_stocking_products_on_sale_id"
    t.index ["stocking_id"], name: "index_stocking_products_on_stocking_id"
  end

  create_table "stockings", force: :cascade do |t|
    t.date "purchase_date"
    t.integer "product_type"
    t.integer "purchase_price"
    t.integer "shipping_cost", default: 0
    t.integer "use_points", default: 0
    t.integer "purchasing_cost", default: 0
    t.integer "payment_type"
    t.integer "purchase_place"
    t.boolean "refund"
    t.string "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "templates", force: :cascade do |t|
    t.integer "category"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
  end

end
