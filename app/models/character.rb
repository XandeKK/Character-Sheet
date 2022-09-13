class Character < ApplicationRecord
  belongs_to :user
  belongs_to :character_category
  belongs_to :character_system
  
end
