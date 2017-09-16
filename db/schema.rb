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

ActiveRecord::Schema.define(version: 20170914163511) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "manga_contents", force: :cascade do |t|
    t.string "img_url"
    t.integer "page_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "manga_id"
    t.index ["manga_id"], name: "index_manga_contents_on_manga_id"
  end

  create_table "manga_titles", force: :cascade do |t|
    t.string "title"
    t.integer "level"
    t.string "genre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_manga_titles_on_user_id"
  end

  create_table "mangas", force: :cascade do |t|
    t.integer "episode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "manga_title_id"
    t.index ["manga_title_id"], name: "index_mangas_on_manga_title_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "manga_contents", "mangas"
  add_foreign_key "manga_titles", "users"
  add_foreign_key "mangas", "manga_titles"
end
