module AdventureParticipationHelper

  def get_participants adventure
    participants = []
  	adventure.adventure_participations.each do |participation|
      character_json = JSON.parse(participation.character.statistic)["character"]
      participants.push({
        character: participation.character,
        character_json: character_json,
        type: participation.character.character_category.name
      })
    end
    participants
  end

  def was_added? character, adventure
    character.adventure_participations.each do |participation| 
      if participation.adventure_id == adventure.id
        return true
      end
    end
    return false
  end
end
