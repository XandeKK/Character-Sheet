class CampaignPlayerController < ApplicationController
  def index
    @player = CharacterCategory.find_by_name("Player")
    @characters = Character.where(user: current_user, character_category: @player)
  end

  def show
  end
end
