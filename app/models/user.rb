class User < ApplicationRecord
  include Clearance::User

  has_many :adventures, dependent: :destroy
  has_many :characters, dependent: :destroy

  validates :name, presence: true
end
