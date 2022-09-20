class PlayerController < ApplicationController
  def index
    @characters = current_user.characters
      .select("characters.id, pathfinder_basics.name")
      .joins(:character_category, :pathfinder_basic)
      .where("character_category.name": "Player")
      .includes(character_image_attachment: :blob)
  end
end
