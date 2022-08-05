class AdventureParticipation < ApplicationRecord
  belongs_to :adventure
  belongs_to :character
end
