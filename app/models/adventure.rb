class Adventure < ApplicationRecord
  belongs_to :user

  has_secure_password

  validates :name, presence: true
  validates :server_name, presence: true, uniqueness: true
  validates :password, presence: true

  def create_server_name
    loop do
      self.server_name = SecureRandom.hex(4)
      break unless self.class.exists?(:server_name => server_name)
    end
  end
end
