class PlayerController < ApplicationController
  def index
    @characters = Character
      .where(user: current_user)
      .includes(:pathfinder_basic)
  end
end
