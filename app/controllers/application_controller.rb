class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :require_login


  private 
  def get_characters
    @characters_dropdown = Character
      .where(character_category: @character.character_category)
      .includes(:pathfinder_basic)
  end
end
