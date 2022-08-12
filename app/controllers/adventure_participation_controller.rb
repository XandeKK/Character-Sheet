class AdventureParticipationController < ApplicationController
  before_action :set_adventure, only: [:create, :destroy]
  before_action :redirect_if_empty, only: [:create, :destroy]

	def create
    @adventure_participation = @adventure.adventure_participations.new(adventure_participation_params)
    @character = @adventure_participation.character

    respond_to do |format|
      if @adventure_participation.save
        format.turbo_stream { render "adventure_participation/create", status: :ok }
      else
        if @character
          format.turbo_stream { render "adventure_participation/destroy", status: :unprocessable_entity }
        else
          format.turbo_stream { render plain: "", status: :unprocessable_entity }
        end
      end
    end
	end

	def destroy
    @adventure_participation = @adventure.adventure_participations.find_by(character_id: params[:character_id])
    @character = @adventure_participation.character

    respond_to do |format|
      if @adventure_participation.destroy
        format.turbo_stream { render "adventure_participation/destroy", status: :ok }
      else
        format.turbo_stream { render "adventure_participation/create", status: :unprocessable_entity }
      end
    end
	end

	private

  def adventure_participation_params
    params.require(:adventure_participation).permit(:character_id)
  end

	def redirect_if_empty
		redirect_to adventures_path, alert: "You do not have permission." if @adventure.nil?
	end

	def set_adventure
		@adventure = Adventure.find_by(id: params[:id], user: current_user)
	end
end
