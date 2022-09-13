class Character < ApplicationRecord
  belongs_to :user
  belongs_to :character_category
  belongs_to :character_system
  
  has_one :pathfinder_basic, class_name: "Pathfinder::Basic", dependent: :destroy
  has_one :pathfinder_ability, class_name: "Pathfinder::Ability", dependent: :destroy
  has_many :pathfinder_feats, class_name: "Pathfinder::Feat", dependent: :destroy
  has_many :pathfinder_languages, class_name: "Pathfinder::Language", dependent: :destroy
  has_one :pathfinder_money, class_name: "Pathfinder::Money", dependent: :destroy
  has_many :pathfinder_items, class_name: "Pathfinder::Item", dependent: :destroy
  has_one :pathfinder_saving_throw, class_name: "Pathfinder::SavingThrow", dependent: :destroy
  # has_one :pathfinder_defense, class_name: "Pathfinder::Defense", dependent: :destroy
  # has_many :pathfinder_melees, class_name: "Pathfinder::Melee", dependent: :destroy
  # has_many :pathfinder_rangeds, class_name: "Pathfinder::Ranged", dependent: :destroy
  # has_many :pathfinder_skills, class_name: "Pathfinder::Skill", dependent: :destroy
  # has_one :pathfinder_spell_casters, class_name: "Pathfinder::SpellCaster", dependent: :destroy
  # has_many :pathfinder_spell, class_name: "Pathfinder::Spell", dependent: :destroy
  # has_many :pathfinder_innate_spell, class_name: "Pathfinder::InnateSpell", dependent: :destroy
  # has_many :pathfinder_focus_spell, class_name: "Pathfinder::FocusSpell", dependent: :destroy
  # has_many :pathfinder_weapon_proficiencies, class_name: "Pathfinder::WeaponProficiency", dependent: :destroy
  # has_one :pathfinder_perception, class_name: "Pathfinder::Perception", dependent: :destroy
  # has_one :pathfinder_class_dc, class_name: "Pathfinder::ClassDc", dependent: :destroy
  # has_many :pathfinder_notes, class_name: "Pathfinder::Note", dependent: :destroy
end








