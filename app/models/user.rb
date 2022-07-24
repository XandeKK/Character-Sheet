class User < ApplicationRecord
  include Clearance::User

  has_many :characters, dependent: :destroy
  has_many :adventures, dependent: :destroy
end
