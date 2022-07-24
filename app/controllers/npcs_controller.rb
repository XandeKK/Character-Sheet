class NpcsController < ApplicationController
  def index
    @character_category = CharacterCategory.find_by_name("Npc")
    @npcs = Character.where(user: current_user, character_category: @character_category)
  end
end
