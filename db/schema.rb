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

ActiveRecord::Schema.define(:version => 20110930221348) do

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options", :force => true do |t|
    t.integer  "event_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price",      :precision => 10, :scale => 2
  end

  add_index "options", ["event_id"], :name => "index_options_on_event_id"

  create_table "orders", :force => true do |t|
    t.integer  "realm_id"
    t.string   "name"
    t.integer  "option_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["option_id"], :name => "index_orders_on_option_id"
  add_index "orders", ["realm_id"], :name => "index_orders_on_realm_id"

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "realms", :force => true do |t|
    t.integer  "organization_id"
    t.integer  "event_id"
    t.string   "token"
    t.string   "admin_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "realms", ["event_id"], :name => "index_realms_on_event_id"
  add_index "realms", ["organization_id"], :name => "index_realms_on_organization_id"

end
