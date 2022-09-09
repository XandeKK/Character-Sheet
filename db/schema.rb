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

ActiveRecord::Schema[7.0].define(version: 2022_09_09_173021) do
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
    t.integer "strength"
    t.integer "dexterity"
    t.integer "constitution"
    t.integer "intelligence"
    t.integer "wisdom"
    t.integer "charisma"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_abilities_on_character_id"
  end

  create_table "pathfinder_armor_classes", force: :cascade do |t|
    t.integer "capable"
    t.integer "proficiency"
    t.integer "unarmored"
    t.integer "light"
    t.integer "medium"
    t.integer "heavy"
    t.integer "shield"
    t.integer "hardness"
    t.integer "maxHp"
    t.integer "broken_threshold"
    t.integer "current_hp"
    t.integer "item"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_armor_classes_on_character_id"
  end

  create_table "pathfinder_class_dcs", force: :cascade do |t|
    t.string "key_ability"
    t.integer "item"
    t.integer "proficiency"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_class_dcs_on_character_id"
  end

  create_table "pathfinder_details", force: :cascade do |t|
    t.string "name", null: false
    t.string "class_name"
    t.string "ancestry"
    t.string "heritage"
    t.string "alignment"
    t.string "background"
    t.string "traits"
    t.integer "level"
    t.integer "hero_points"
    t.integer "size"
    t.integer "experience_points"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_details_on_character_id"
  end

  create_table "pathfinder_feat_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pathfinder_feats", force: :cascade do |t|
    t.string "level"
    t.string "name"
    t.text "notes"
    t.bigint "character_id", null: false
    t.bigint "pathfinder_feat_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_feats_on_character_id"
    t.index ["pathfinder_feat_category_id"], name: "index_pathfinder_feats_on_pathfinder_feat_category_id"
  end

  create_table "pathfinder_hit_points", force: :cascade do |t|
    t.integer "max_hp"
    t.integer "current_hp"
    t.integer "temporary_hp"
    t.string "resistances_and_immunities"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_hit_points_on_character_id"
  end

  create_table "pathfinder_inventories", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.integer "bulk"
    t.string "notes"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_inventories_on_character_id"
  end

  create_table "pathfinder_languages", force: :cascade do |t|
    t.string "name"
    t.text "notes"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_languages_on_character_id"
  end

  create_table "pathfinder_melee_strikes", force: :cascade do |t|
    t.string "weapon"
    t.string "weapon_strength"
    t.integer "proficiency"
    t.integer "item"
    t.integer "dice"
    t.string "types"
    t.string "damage_strength"
    t.string "weapon_specialization"
    t.string "traits"
    t.string "other"
    t.text "notes"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_melee_strikes_on_character_id"
  end

  create_table "pathfinder_money", force: :cascade do |t|
    t.integer "pp"
    t.integer "gp"
    t.integer "sp"
    t.integer "cp"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_money_on_character_id"
  end

  create_table "pathfinder_perceptions", force: :cascade do |t|
    t.integer "item"
    t.string "senses"
    t.integer "proficiency"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_perceptions_on_character_id"
  end

  create_table "pathfinder_ranged_strikes", force: :cascade do |t|
    t.string "weapon"
    t.string "weapon_dexterity"
    t.integer "proficiency"
    t.integer "item"
    t.integer "dice"
    t.string "types"
    t.string "special"
    t.string "weapon_specialization"
    t.string "range"
    t.string "traits"
    t.string "other"
    t.text "notes"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_ranged_strikes_on_character_id"
  end

  create_table "pathfinder_saving_throws", force: :cascade do |t|
    t.integer "fortitude"
    t.integer "fortitude_item"
    t.integer "will"
    t.integer "will_item"
    t.integer "reflex"
    t.integer "reflex_item"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_saving_throws_on_character_id"
  end

  create_table "pathfinder_skills", force: :cascade do |t|
    t.string "name"
    t.string "ability"
    t.integer "proficiency"
    t.integer "item"
    t.integer "armor"
    t.string "notes"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_skills_on_character_id"
  end

  create_table "pathfinder_speeds", force: :cascade do |t|
    t.integer "feet"
    t.string "movement_types"
    t.text "notes"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_speeds_on_character_id"
  end

  create_table "pathfinder_weapon_profics", force: :cascade do |t|
    t.string "name"
    t.integer "proficiency"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_weapon_profics_on_character_id"
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
  add_foreign_key "pathfinder_armor_classes", "characters"
  add_foreign_key "pathfinder_class_dcs", "characters"
  add_foreign_key "pathfinder_details", "characters"
  add_foreign_key "pathfinder_feats", "characters"
  add_foreign_key "pathfinder_feats", "pathfinder_feat_categories"
  add_foreign_key "pathfinder_hit_points", "characters"
  add_foreign_key "pathfinder_inventories", "characters"
  add_foreign_key "pathfinder_languages", "characters"
  add_foreign_key "pathfinder_melee_strikes", "characters"
  add_foreign_key "pathfinder_money", "characters"
  add_foreign_key "pathfinder_perceptions", "characters"
  add_foreign_key "pathfinder_ranged_strikes", "characters"
  add_foreign_key "pathfinder_saving_throws", "characters"
  add_foreign_key "pathfinder_skills", "characters"
  add_foreign_key "pathfinder_speeds", "characters"
  add_foreign_key "pathfinder_weapon_profics", "characters"
end
