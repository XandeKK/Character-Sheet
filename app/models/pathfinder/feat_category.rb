class Pathfinder::FeatCategory < ApplicationRecord
  has_many :pathfinder_feats, dependent: :destroy, class_name: "Pathfinder::Feat", foreign_key: "pathfinder_feat_category_id"
  validates :name, presence: true
end
