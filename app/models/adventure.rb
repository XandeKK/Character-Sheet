class Adventure < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :unique_name, presence: true, uniqueness: true

  def create_unique_name
    loop do
      self.unique_name = SecureRandom.hex(4)
      break unless self.class.exists?(:unique_name => unique_name)
    end
  end
end
