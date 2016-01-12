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

ActiveRecord::Schema.define(version: 20160106095004) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_image_links", force: :cascade do |t|
    t.string   "link_name"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "product_image_links", ["product_id"], name: "index_product_image_links_on_product_id"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "price"
    t.text     "description"
    t.integer  "quantity"
    t.string   "code"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "brand"
    t.string   "size"
    t.integer  "subcategory_id"
  end

  add_index "products", ["subcategory_id"], name: "index_products_on_subcategory_id"

  create_table "specifications", force: :cascade do |t|
    t.string   "key"
    t.text     "value"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "specifications", ["product_id"], name: "index_specifications_on_product_id"

  create_table "subcategories", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "subcategories", ["category_id"], name: "index_subcategories_on_category_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "password_digest"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "activation_token"
    t.boolean  "active_status"
  end

end
