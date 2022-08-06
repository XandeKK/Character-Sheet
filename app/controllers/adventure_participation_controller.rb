class AdventureParticipationController < ApplicationController
  before_action :set_adventure, only: [:create, :destroy]
  before_action :redirect_if_empty, only: [:create, :destroy]

	def create
    @adventure_participation = @adventure.adventure_participations.new(adventure_participation_params)
    @character = @adventure_participation.character

    respond_to do |format|
      if @adventure_participation.save
        format.html { render html: "any", status: :ok }
        format.turbo_stream
      else
        format.html { render html: "any", status: :unprocessable_entity }
      end
    end
	end

	def destroy
    @adventure_participation = @adventure.adventure_participations.find_by_id(params[:adventure_participation_id])
    @character = @adventure_participation.character

    respond_to do |format|
      if @adventure_participation.destroy
        format.html { render html: "any", status: :ok }
        format.turbo_stream
      else
        format.html { render html: "any", status: :unprocessable_entity }
      end
    end
	end

	private

  def adventure_participation_params
    params.require(:adventure_participation).permit(:character_id)
  end

	def redirect_if_empty
		redirect_to adventures_path, alert: "You do not have permission.", status: :unprocessable_entity if @adventure.nil?
	end

	def set_adventure
		@adventure = Adventure.find_by(id: params[:id], user: current_user)
	end
end
