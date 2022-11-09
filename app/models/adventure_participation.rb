class AdventureParticipation < ApplicationRecord
  belongs_to :character
  belongs_to :adventure
  has_one :character_category, through: :character
  has_one :character_image_blob, through: :character
  has_one :pathfinder_basic, through: :character
  has_one :pathfinder_ability, through: :character
  has_one :pathfinder_money, through: :character
  has_one :pathfinder_saving_throw, through: :character
  has_one :pathfinder_defense, through: :character
  has_one :pathfinder_spell_caster, through: :character
  has_one :pathfinder_perception, through: :character
  has_one :pathfinder_class_dc, through: :character
  has_many :pathfinder_spells, through: :character
  has_many :pathfinder_melees, through: :character
  has_many :pathfinder_items, through: :character
  has_many :pathfinder_feats, through: :character
  has_many :pathfinder_languages, through: :character
  has_many :pathfinder_rangeds, through: :character
  has_many :pathfinder_skills, through: :character
  has_many :pathfinder_focus_spells, through: :character
  has_many :pathfinder_weapon_proficiencies, through: :character
  has_many :pathfinder_innate_spells, through: :character
  has_many :pathfinder_notes, through: :character
  has_many :dices, through: :character

  scope :includes_all, -> { includes(
        :character_category,
        :character,
        :character_image_blob,
        :pathfinder_basic,
        :pathfinder_ability,
        :pathfinder_saving_throw,
        :pathfinder_defense,
        :pathfinder_perception,
        :pathfinder_class_dc,
        :pathfinder_melees,
        :pathfinder_languages,
        :pathfinder_rangeds,
        :pathfinder_skills,
        :pathfinder_notes,
        :dices
      ) }
end
