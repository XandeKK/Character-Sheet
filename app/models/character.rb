class Character < ApplicationRecord
  belongs_to :user
  belongs_to :character_category
  belongs_to :character_system
  
  has_one :pathfinder_basics, class_name: "Pathfinder::Basic", dependent: :destroy
end
