class Pathfinder::Feat < ApplicationRecord
  belongs_to :character
  belongs_to :pathfinder_feat_category, class_name: "Pathfinder::FeatCategory"
end
