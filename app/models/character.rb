class Character < ApplicationRecord
  belongs_to :user
  belongs_to :character_category
  belongs_to :character_system

  has_one :pathfinder_detail, dependent: :destroy, class_name: "Pathfinder::Detail"
  has_one :pathfinder_hit_point, dependent: :destroy, class_name: "Pathfinder::HitPoint"
  has_one :pathfinder_ability, dependent: :destroy, class_name: "Pathfinder::Ability"
  has_one :pathfinder_armor_class, dependent: :destroy, class_name: "Pathfinder::ArmorClass"
  has_one :pathfinder_class_dc, dependent: :destroy, class_name: "Pathfinder::ClassDc"
  has_one :pathfinder_perception, dependent: :destroy, class_name: "Pathfinder::Perception"
  has_one :pathfinder_speed, dependent: :destroy, class_name: "Pathfinder::Speed"
  has_one :pathfinder_saving_throw, dependent: :destroy, class_name: "Pathfinder::SavingThrow"
  has_many :pathfinder_skills, dependent: :destroy, class_name: "Pathfinder::Skill"
  has_many :pathfinder_melee_strikes, dependent: :destroy, class_name: "Pathfinder::MeleeStrike"
  has_many :pathfinder_ranged_strikes, dependent: :destroy, class_name: "Pathfinder::RangedStrike"
  has_many :pathfinder_languages, dependent: :destroy, class_name: "Pathfinder::Language"
  has_many :pathfinder_weapon_profics, dependent: :destroy, class_name: "Pathfinder::WeaponProfic"
  has_many :pathfinder_feats, dependent: :destroy, class_name: "Pathfinder::Feat"
  has_many :pathfinder_inventories, dependent: :destroy, class_name: "Pathfinder::Inventory"
  has_one :pathfinder_money, dependent: :destroy, class_name: "Pathfinder::Money"

  accepts_nested_attributes_for :pathfinder_detail, :pathfinder_hit_point, :pathfinder_ability, :pathfinder_armor_class, :pathfinder_class_dc, :pathfinder_perception, :pathfinder_speed, :pathfinder_saving_throw, :pathfinder_skills, :pathfinder_melee_strikes, :pathfinder_ranged_strikes, :pathfinder_languages, :pathfinder_weapon_profics, :pathfinder_feats, :pathfinder_inventories, :pathfinder_money

  scope :character, ->(id, user) { 
    where(id: id, user: user)
    .includes(
      :pathfinder_detail,
      :pathfinder_hit_point,
      :pathfinder_ability,
      :pathfinder_armor_class,
      :pathfinder_class_dc,
      :pathfinder_perception,
      :pathfinder_speed,
      :pathfinder_saving_throw,
      :pathfinder_skills,
      :pathfinder_melee_strikes,
      :pathfinder_ranged_strikes,
      :pathfinder_languages,
      :pathfinder_weapon_profics,
      :pathfinder_feats,
      :pathfinder_inventories,
      :pathfinder_money
    )
  }
end
