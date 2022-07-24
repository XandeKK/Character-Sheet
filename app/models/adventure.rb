class Adventure < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :unique_name, presence: true
end
