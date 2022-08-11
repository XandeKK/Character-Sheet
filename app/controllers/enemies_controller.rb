class EnemiesController < ApplicationController
  def index
    @enemies = Character.where(user: current_user, character_category_id: 2)
  end
end
