class Character < ApplicationRecord
  belongs_to :user
  has_one_attached :character_image

  validates :name, presence: true
end
