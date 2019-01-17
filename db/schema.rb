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

ActiveRecord::Schema.define(version: 2019_01_12_104505) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "auth_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "public_site", default: false
    t.string "rss_auth_token"
    t.string "login", null: false
  end

  create_table "bookmarks", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tags", array: true
    t.boolean "shared", default: true
    t.bigint "account_id"
    t.index ["account_id"], name: "index_bookmarks_on_account_id"
  end

  create_table "bundles", force: :cascade do |t|
    t.bigint "account_id"
    t.string "name"
    t.text "tags"
    t.boolean "shared", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_bundles_on_account_id"
  end

  add_foreign_key "bookmarks", "accounts"
end
