module ShowCharactersHelper
  def get_perception
    modifier = get_modifier('wis')
    item = @character.pathfinder_perception.item || 0
    proficiency = @character.pathfinder_perception.proficiency || 0

    modifier + item + proficiency
  end

  def get_modifier(ability)
    score = @character.pathfinder_ability["#{ability}_total"] || 0
    ((score/2) - 5).floor
  end
end