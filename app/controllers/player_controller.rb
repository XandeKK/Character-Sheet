class PlayerController < ApplicationController
  def index
    @characters = Character
      .joins(:pathfinder_detail)
      .where(user: current_user)
      .all
  end
end
