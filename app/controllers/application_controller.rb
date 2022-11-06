class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :require_login

  private
  def get_characters
    @characters_dropdown = Character
      .where(character_category: @character.character_category)
      .includes(:pathfinder_basic)
  end

  def save_image
    unless params[:character][:image].empty?
      @character.character_image.attach(data: params[:character][:image])
    end
  end

  def redirect_by_character_category character
    character_category = CharacterCategory.all
    case character.character_category_id
    when character_category[0].id
      redirect_to character_path(character), notice: "Character successfully updated!"
    when character_category[1].id
      redirect_to npc_path(character), notice: "Npc successfully updated!"
    when character_category[2].id
      redirect_to enemy_path(character), notice: "Enemy successfully updated!"
    end
  end
end
