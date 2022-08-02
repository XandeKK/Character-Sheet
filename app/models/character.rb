class Character < ApplicationRecord
  # before_update 
  belongs_to :character_category
  belongs_to :user
  has_one_attached :character_image

  validates :name, presence: true
  validate :if_json_valid?

  def if_json_valid?
    begin
      JSON.parse self.statistic
    rescue
      errors.add(:statistic, "could not save with json invalid.")
    end
  end

  def create_character current_user, category
    player = CharacterCategory.find_by_name(category)

    self.name = "undefined"
    character_json = File.read("#{Rails.root}/app/models/json/character.json")
    character_json = JSON.parse character_json
    self.statistic = character_json.to_json

    self.character_category = player
    self.user = current_user

    self.save
  end
end
