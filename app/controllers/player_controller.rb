class PlayerController < ApplicationController
  def index
    @characters = current_user.characters
      .select("characters.id, pathfinder_basics.name")
      .joins(:pathfinder_basic)
      .includes(character_image_attachment: :blob)
  end
end
