# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_09_13_233916) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adventures", force: :cascade do |t|
    t.string "name"
    t.string "server_name"
    t.string "password_digest"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_adventures_on_user_id"
  end

  create_table "character_categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "character_systems", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "characters", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "character_category_id", null: false
    t.bigint "character_system_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_category_id"], name: "index_characters_on_character_category_id"
    t.index ["character_system_id"], name: "index_characters_on_character_system_id"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "pathfinder_abilities", force: :cascade do |t|
    t.integer "str_total"
    t.integer "str_free"
    t.integer "str_class"
    t.integer "str_ascentry"
    t.integer "str_background"
    t.integer "dex_total"
    t.integer "dex_free"
    t.integer "dex_class"
    t.integer "dex_ascentry"
    t.integer "dex_background"
    t.integer "con_total"
    t.integer "con_free"
    t.integer "con_class"
    t.integer "con_ascentry"
    t.integer "con_background"
    t.integer "int_total"
    t.integer "int_free"
    t.integer "int_class"
    t.integer "int_ascentry"
    t.integer "int_background"
    t.integer "wis_total"
    t.integer "wis_free"
    t.integer "wis_class"
    t.integer "wis_ascentry"
    t.integer "wis_background"
    t.integer "cha_total"
    t.integer "cha_free"
    t.integer "cha_class"
    t.integer "cha_ascentry"
    t.integer "cha_background"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_abilities_on_character_id"
  end

  create_table "pathfinder_basics", force: :cascade do |t|
    t.string "name"
    t.string "class_name"
    t.string "ancestry"
    t.string "heritage"
    t.text "heritage_note"
    t.string "background"
    t.string "alignment"
    t.string "deity"
    t.string "key_ability"
    t.integer "age"
    t.integer "level"
    t.integer "hero_points"
    t.string "size"
    t.string "speed"
    t.text "speed_note"
    t.text "description"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_basics_on_character_id"
  end

  create_table "pathfinder_feats", force: :cascade do |t|
    t.string "name"
    t.string "types"
    t.text "notes"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_feats_on_character_id"
  end

  create_table "pathfinder_languages", force: :cascade do |t|
    t.string "name"
    t.text "notes"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_languages_on_character_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token", unique: true
  end

  add_foreign_key "adventures", "users"
  add_foreign_key "characters", "character_categories"
  add_foreign_key "characters", "character_systems"
  add_foreign_key "characters", "users"
  add_foreign_key "pathfinder_abilities", "characters"
  add_foreign_key "pathfinder_basics", "characters"
  add_foreign_key "pathfinder_feats", "characters"
  add_foreign_key "pathfinder_languages", "characters"
end
