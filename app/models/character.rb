class Character < ApplicationRecord
  has_one_base64_attached :character_image
  belongs_to :user
  belongs_to :character_category
  belongs_to :character_system

  has_many :adventure_participations, dependent: :destroy

  has_one :pathfinder_basic, class_name: "Pathfinder::Basic", dependent: :destroy
  has_one :pathfinder_ability, class_name: "Pathfinder::Ability", dependent: :destroy
  has_one :pathfinder_money, class_name: "Pathfinder::Money", dependent: :destroy
  has_one :pathfinder_saving_throw, class_name: "Pathfinder::SavingThrow", dependent: :destroy
  has_one :pathfinder_defense, class_name: "Pathfinder::Defense", dependent: :destroy
  has_one :pathfinder_spell_caster, class_name: "Pathfinder::SpellCaster", dependent: :destroy
  has_one :pathfinder_perception, class_name: "Pathfinder::Perception", dependent: :destroy
  has_one :pathfinder_class_dc, class_name: "Pathfinder::ClassDc", dependent: :destroy
  has_many :pathfinder_spells, class_name: "Pathfinder::Spell", dependent: :destroy
  has_many :pathfinder_melees, class_name: "Pathfinder::Melee", dependent: :destroy
  has_many :pathfinder_items, class_name: "Pathfinder::Item", dependent: :destroy
  has_many :pathfinder_feats, class_name: "Pathfinder::Feat", dependent: :destroy
  has_many :pathfinder_languages, class_name: "Pathfinder::Language", dependent: :destroy
  has_many :pathfinder_rangeds, class_name: "Pathfinder::Ranged", dependent: :destroy
  has_many :pathfinder_skills, class_name: "Pathfinder::Skill", dependent: :destroy
  has_many :pathfinder_focus_spells, class_name: "Pathfinder::FocusSpell", dependent: :destroy
  has_many :pathfinder_weapon_proficiencies, class_name: "Pathfinder::WeaponProficiency", dependent: :destroy
  has_many :pathfinder_innate_spells, class_name: "Pathfinder::InnateSpell", dependent: :destroy
  has_many :pathfinder_notes, class_name: "Pathfinder::Note", dependent: :destroy
  has_many :dices, dependent: :destroy

  accepts_nested_attributes_for :pathfinder_basic, :pathfinder_ability, :pathfinder_money, :pathfinder_saving_throw, :pathfinder_defense, :pathfinder_spell_caster, :pathfinder_perception, :pathfinder_class_dc, update_only: true

  accepts_nested_attributes_for :pathfinder_spells, :pathfinder_melees, :pathfinder_items, :pathfinder_feats, :pathfinder_languages, :pathfinder_rangeds, :pathfinder_skills, :pathfinder_focus_spells, :pathfinder_weapon_proficiencies, :pathfinder_innate_spells, :pathfinder_notes, :dices, reject_if: :all_blank, allow_destroy: true

  scope :pathfinder, -> { includes(:pathfinder_basic, :pathfinder_ability, :pathfinder_money, :pathfinder_saving_throw, :pathfinder_defense, :pathfinder_spell_caster, :pathfinder_perception, :pathfinder_class_dc, :pathfinder_spells, :pathfinder_melees, :pathfinder_items, :pathfinder_feats, :pathfinder_languages, :pathfinder_rangeds, :pathfinder_skills, :pathfinder_focus_spells, :pathfinder_weapon_proficiencies, :pathfinder_innate_spells, :pathfinder_notes, :dices) }
  scope :select_of, ->(category) { select("characters.id, pathfinder_basics.name")
      .joins(:character_category, :pathfinder_basic)
      .where("character_category.name": category)
      .includes(character_image_attachment: :blob)}
end








