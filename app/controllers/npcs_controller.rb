class NpcsController < ApplicationController
  def index
    @npcs = Character.where(user: current_user, character_category_id: 3)
  end
end
