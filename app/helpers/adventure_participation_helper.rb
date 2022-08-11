module AdventureParticipationHelper

  def get_participants adventure
    participants = []
    adventure_participations = adventure.adventure_participations
  	adventure_participations.each do |participation|
      participants.push(participation.character_id)
    end
    participants
  end
end
