class CharacterSystem < ApplicationRecord
  has_many :characters

  validates :name, presence: true
end
