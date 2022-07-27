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
end
