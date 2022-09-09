class Pathfinder::Detail < ApplicationRecord
  belongs_to :character

  validates :name, presence: true
end
