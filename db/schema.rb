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

ActiveRecord::Schema.define(version: 2019_03_19_204819) do

  create_table "slack_credentials", force: :cascade do |t|
    t.string "confirmation_token"
    t.datetime "confirmation_token_date"
    t.string "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bot_user_id"
    t.string "bot_access_token"
  end

  create_table "slack_users", force: :cascade do |t|
    t.string "slack_id"
    t.string "team_id"
    t.string "real_name"
    t.string "display_name"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "image_original"
    t.boolean "is_custom_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
