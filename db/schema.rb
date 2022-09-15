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

ActiveRecord::Schema[7.0].define(version: 2022_09_14_102622) do
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

  create_table "pathfinder_class_dcs", force: :cascade do |t|
    t.integer "item"
    t.integer "proficiency"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_class_dcs_on_character_id"
  end

  create_table "pathfinder_defenses", force: :cascade do |t|
    t.integer "max_hp"
    t.integer "current_hp"
    t.integer "ancestry_hp"
    t.integer "class_hp"
    t.integer "temp_hp"
    t.string "resistances_and_immunities"
    t.string "conditions"
    t.integer "dying"
    t.integer "wounded"
    t.integer "armor_class_item"
    t.integer "armor_class_proficiency"
    t.integer "heavy_proficiency"
    t.integer "medium_proficiency"
    t.integer "light_proficiency"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_defenses_on_character_id"
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

  create_table "pathfinder_focus_spells", force: :cascade do |t|
    t.string "name"
    t.text "notes"
    t.string "spell_component"
    t.string "action"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_focus_spells_on_character_id"
  end

  create_table "pathfinder_innate_spells", force: :cascade do |t|
    t.string "name"
    t.text "notes"
    t.integer "frequency"
    t.string "spell_component"
    t.string "action"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_innate_spells_on_character_id"
  end

  create_table "pathfinder_items", force: :cascade do |t|
    t.string "name"
    t.integer "quatity"
    t.integer "weight"
    t.text "notes"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_items_on_character_id"
  end

  create_table "pathfinder_languages", force: :cascade do |t|
    t.string "name"
    t.text "notes"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_languages_on_character_id"
  end

  create_table "pathfinder_melees", force: :cascade do |t|
    t.string "name"
    t.integer "qty"
    t.string "types"
    t.integer "proficiency"
    t.string "traits"
    t.string "weapon_specialization"
    t.string "die"
    t.integer "item"
    t.string "other"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_melees_on_character_id"
  end

  create_table "pathfinder_money", force: :cascade do |t|
    t.integer "platinum"
    t.integer "gold"
    t.integer "silver"
    t.integer "copper"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_money_on_character_id"
  end

  create_table "pathfinder_notes", force: :cascade do |t|
    t.string "name"
    t.text "note"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_notes_on_character_id"
  end

  create_table "pathfinder_perceptions", force: :cascade do |t|
    t.integer "item"
    t.integer "proficiency"
    t.string "senses"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_perceptions_on_character_id"
  end

  create_table "pathfinder_rangeds", force: :cascade do |t|
    t.string "name"
    t.integer "qty"
    t.string "types"
    t.string "range"
    t.integer "proficiency"
    t.string "other"
    t.string "traits"
    t.string "weapon_specialization"
    t.integer "special"
    t.string "die"
    t.integer "item"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_rangeds_on_character_id"
  end

  create_table "pathfinder_saving_throws", force: :cascade do |t|
    t.integer "fortitude_total"
    t.integer "reflex_total"
    t.integer "will_total"
    t.integer "fortitude_proficiency"
    t.integer "reflex_proficiency"
    t.integer "will_proficiency"
    t.integer "fortitude_item"
    t.integer "reflex_item"
    t.integer "will_item"
    t.integer "fortitude_misc"
    t.integer "reflex_misc"
    t.integer "will_misc"
    t.integer "fortitude_penalty"
    t.integer "reflex_penalty"
    t.integer "will_penalty"
    t.text "saving_throw_notes"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_saving_throws_on_character_id"
  end

  create_table "pathfinder_skills", force: :cascade do |t|
    t.string "name"
    t.text "note"
    t.string "key_ability"
    t.integer "proficiency"
    t.integer "item"
    t.integer "armor"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_skills_on_character_id"
  end

  create_table "pathfinder_spell_casters", force: :cascade do |t|
    t.string "magic_tradition"
    t.string "spellcasting_type"
    t.integer "attack_proficiency"
    t.integer "attack_bonus"
    t.integer "attack_penalty"
    t.integer "cd_proficiency"
    t.integer "cd_bonus"
    t.integer "cd_penalty"
    t.integer "max_focus_points"
    t.integer "current_focus_points"
    t.integer "level_0"
    t.integer "level_1"
    t.integer "level_2"
    t.integer "level_3"
    t.integer "level_4"
    t.integer "level_5"
    t.integer "level_6"
    t.integer "level_7"
    t.integer "level_8"
    t.integer "level_9"
    t.integer "level_10"
    t.text "notes"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_spell_casters_on_character_id"
  end

  create_table "pathfinder_spells", force: :cascade do |t|
    t.integer "level"
    t.string "name"
    t.text "notes"
    t.integer "prepared"
    t.string "spell_component"
    t.string "action"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_spells_on_character_id"
  end

  create_table "pathfinder_weapon_proficiencies", force: :cascade do |t|
    t.string "name"
    t.integer "proficiency"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_pathfinder_weapon_proficiencies_on_character_id"
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
  add_foreign_key "pathfinder_class_dcs", "characters"
  add_foreign_key "pathfinder_defenses", "characters"
  add_foreign_key "pathfinder_feats", "characters"
  add_foreign_key "pathfinder_focus_spells", "characters"
  add_foreign_key "pathfinder_innate_spells", "characters"
  add_foreign_key "pathfinder_items", "characters"
  add_foreign_key "pathfinder_languages", "characters"
  add_foreign_key "pathfinder_melees", "characters"
  add_foreign_key "pathfinder_money", "characters"
  add_foreign_key "pathfinder_notes", "characters"
  add_foreign_key "pathfinder_perceptions", "characters"
  add_foreign_key "pathfinder_rangeds", "characters"
  add_foreign_key "pathfinder_saving_throws", "characters"
  add_foreign_key "pathfinder_skills", "characters"
  add_foreign_key "pathfinder_spell_casters", "characters"
  add_foreign_key "pathfinder_spells", "characters"
  add_foreign_key "pathfinder_weapon_proficiencies", "characters"
end
