module PathfinderCharacter
  def self.create_character(user, category, character_system)
    @character = Character.new(
      user: user,
      character_category: category,
      character_system_id: character_system
    )

    if @character.save
      return @character
    else
      return nil
    end
  end

  def self.character_params params
  end
end