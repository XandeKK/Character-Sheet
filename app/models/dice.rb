class Dice < ApplicationRecord
  belongs_to :character

  validates :name, presence: true
  validates :notation, presence: true
end
