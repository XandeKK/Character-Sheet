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
    case character.character_category_id
    when 1
      redirect_to character_path(character), notice: "Character successfully updated!"
    when 2
      redirect_to npc_path(character), notice: "Npc successfully updated!"
    when 3
      redirect_to enemy_path(character), notice: "Enemy successfully updated!"
    end
  end
end
