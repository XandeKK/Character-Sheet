class EnemiesController < ApplicationController
  def index
    @character_category = CharacterCategory.find_by_name("Enemy")
    @enemies = Character.find_by(user: current_user, character_category: @character_category)
  end
end
