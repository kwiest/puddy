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

ActiveRecord::Schema.define(:version => 20150206165124) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cached_slug"
    t.string   "primary_email"
    t.string   "address_street"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_postal_code"
    t.string   "phone_number"
    t.boolean  "use_system_gateway",  :default => false
    t.string   "stripe_token"
  end

  create_table "add_ons", :force => true do |t|
    t.integer  "camper_id"
    t.integer  "amount_cents",    :default => 0,     :null => false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "amount_currency", :default => "USD"
  end

  create_table "admins", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "name"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.integer  "camper_id"
    t.string   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "camp_id"
    t.integer  "fee_id"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "email"
    t.date     "birthdate"
    t.string   "school"
    t.string   "address_street"
    t.string   "address_street2"
    t.string   "address_city"
    t.string   "address_state"
    t.string   "address_zip"
    t.string   "address_country"
    t.string   "primary_phone"
    t.string   "secondary_phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.text     "notes"
    t.boolean  "online_camper"
    t.tsvector "search"
    t.string   "tags",            :limit => nil, :default => "{}"
  end

  add_index "campers", ["search"], :name => "campers_search_index"

  create_table "camps", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "timezone"
    t.string   "state",                                     :default => "closed"
    t.boolean  "allow_deposit",                             :default => false
    t.integer  "deposit_amount_cents",                      :default => 0,        :null => false
    t.text     "waiver"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "website"
    t.boolean  "online_fee",                                :default => false
    t.integer  "online_fee_amount_cents",                   :default => 0,        :null => false
    t.text     "confirmation_email"
    t.string   "deposit_amount_currency",                   :default => "USD"
    t.string   "online_fee_amount_currency",                :default => "USD"
    t.string   "start_time"
    t.string   "end_time"
    t.tsvector "name_search"
    t.string   "tags",                       :limit => nil, :default => "{}"
  end

  add_index "camps", ["name_search"], :name => "camps_name_search_index"

  create_table "choices", :force => true do |t|
    t.integer  "question_id"
    t.string   "value"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "credit_cards", :force => true do |t|
    t.integer  "payment_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address1"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "brand"
    t.integer  "month"
    t.integer  "year"
    t.string   "last_digits"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

# Could not dump table "events" because of following StandardError
#   Unknown type 'hstore' for column 'data'

  create_table "fees", :force => true do |t|
    t.integer  "camp_id"
    t.integer  "amount_cents",    :default => 0,     :null => false
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "amount_currency", :default => "USD"
  end

  create_table "payment_gateways", :force => true do |t|
    t.integer  "account_id"
    t.string   "type"
    t.text     "login"
    t.text     "password"
    t.text     "user"
    t.boolean  "amex"
    t.boolean  "discover"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "amount_cents",    :default => 0,     :null => false
    t.string   "payment_type"
    t.string   "description"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "amount_currency", :default => "USD"
  end

  create_table "puddy_invoices", :force => true do |t|
    t.integer  "account_id"
    t.integer  "month"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "payable"
    t.integer  "amount_cents",    :default => 0
    t.string   "amount_currency", :default => "USD"
    t.string   "state",           :default => "pending"
  end

  create_table "questions", :force => true do |t|
    t.integer  "camp_id"
    t.string   "prompt"
    t.string   "data_type",     :default => "string"
    t.boolean  "required"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hint"
    t.boolean  "private",       :default => false
    t.boolean  "section_break", :default => false
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "transactions", :force => true do |t|
    t.integer  "payment_id"
    t.integer  "amount_cents",    :default => 0,     :null => false
    t.boolean  "success"
    t.string   "reference"
    t.string   "message"
    t.string   "action"
    t.text     "params"
    t.boolean  "test"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "amount_currency", :default => "USD"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
