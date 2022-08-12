class Adventure < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user
  has_many :adventure_participations, dependent: :destroy

  validates :name, presence: true
  validates :unique_name, presence: true, uniqueness: true

  def create_unique_name
    loop do
      self.unique_name = SecureRandom.hex(4)
      break unless self.class.exists?(:unique_name => unique_name)
    end
  end

  def should_generate_new_friendly_id?
    name_changed?
  end
end
