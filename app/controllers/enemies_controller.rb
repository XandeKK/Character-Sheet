class EnemiesController < ApplicationController
  def index
    @character_category = CharacterCategory.find_by_name("Enemy")
    @enemies = Character.where(user: current_user, character_category: @character_category)
  end
end
