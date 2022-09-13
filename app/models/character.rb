class Character < ApplicationRecord
  belongs_to :user
  belongs_to :character_category
  belongs_to :character_system
  
  has_one :pathfinder_basics, class_name: "Pathfinder::Basic", dependent: :destroy
  has_one :pathfinder_abilities, class_name: "Pathfinder::Ability", dependent: :destroy
  has_one :pathfinder_feats, class_name: "Pathfinder::Feat", dependent: :destroy
  has_one :pathfinder_languages, class_name: "Pathfinder::Language", dependent: :destroy
end
