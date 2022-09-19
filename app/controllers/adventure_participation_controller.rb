class AdventureParticipationController < ApplicationController
  def create
    @adventure_participation = AdventureParticipation.new(adventure_participation_params)

    if @adventure_participation.save
      head :ok
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  def destroy
    @adventure_participation = AdventureParticipation.find_by(
      character_id: params[:character_id], adventure_id: params[:adventure_id]
    )

    if @adventure_participation.destroy
      head :ok
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  private

  def adventure_participation_params
    params.permit(:character_id, :adventure_id)
  end
end
