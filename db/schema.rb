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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130601175241) do

  create_table "business_profile_food_products", :force => true do |t|
    t.integer  "business_profile_id"
    t.integer  "food_product_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "business_profile_product_categories", :force => true do |t|
    t.integer  "business_profile_id"
    t.integer  "product_category_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "business_profiles", :force => true do |t|
    t.integer  "business_id"
    t.string   "producer_types"
    t.string   "customer_types"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "businesses", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "food_products", :force => true do |t|
    t.integer  "product_category_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "markets", :primary_key => "fmid", :force => true do |t|
    t.string   "market_name"
    t.string   "website"
    t.string   "street"
    t.string   "city"
    t.string   "county"
    t.string   "state"
    t.string   "zip"
    t.float    "x"
    t.float    "y"
    t.string   "location"
    t.string   "credit"
    t.string   "wic"
    t.string   "wic_cash"
    t.string   "sfmnp"
    t.string   "snap"
    t.string   "bakedgoods"
    t.string   "cheese"
    t.string   "crafts"
    t.string   "flowers"
    t.string   "eggs"
    t.string   "seafood"
    t.string   "herbs"
    t.string   "vegetables"
    t.string   "honey"
    t.string   "jams"
    t.string   "maple"
    t.string   "meat"
    t.string   "nursery"
    t.string   "nuts"
    t.string   "plants"
    t.string   "poultry"
    t.string   "prepared"
    t.string   "soap"
    t.string   "trees"
    t.string   "wine"
    t.string   "update_time"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "schedule"
  end

  create_table "product_categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
