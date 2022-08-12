class Character < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :character_category
  belongs_to :user
  has_one_base64_attached :character_image
  has_many :adventure_participations, dependent: :destroy

  validates :name, presence: true
  validate :if_json_valid?

  def should_generate_new_friendly_id?
    name_changed?
  end

  def if_json_valid?
    begin
      JSON.parse self.statistic
    rescue
      errors.add(:statistic, "could not save with json invalid.")
    end
  end

  def create_character current_user, category
    player = CharacterCategory.find_by_name(category)

    self.name = "nameless"
    character_json = File.read("#{Rails.root}/app/models/json/character.json")
    character_json = JSON.parse character_json
    self.statistic = character_json.to_json

    self.character_category = player
    self.user = current_user

    self.save
  end

  def update_life data
    currentHp = data[1]["currentHp"]
    temporary = data[1]["temporary"]

    statistic = JSON.parse(self.statistic)
    statistic["character"]["hitPoints"]["currentHp"] = currentHp
    statistic["character"]["hitPoints"]["temporary"] = temporary

    self.update!(statistic: statistic.to_json)
  end
end
