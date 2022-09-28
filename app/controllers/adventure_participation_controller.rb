class AdventureParticipationController < ApplicationController
  def create
    @adventure_participation = AdventureParticipation.new(adventure_participation_params)

    if @adventure_participation.save
      respond_to do |format|
        format.turbo_stream {
          render "adventure_participation/create",
            locals: {participation: @adventure_participation},
            status: :ok
        }
      end
    else
      render json: nil, status: :unprocessable_entity
    end
  end

  def destroy
    @adventure_participation = AdventureParticipation.find_by(
      character_id: params[:character_id], adventure_id: params[:adventure_id]
    )

    unless @adventure_participation.nil?
      if @adventure_participation.destroy
        head :ok
      else
        render json: nil, status: :unprocessable_entity
      end
    else
      render json: nil, status: :unprocessable_entity
    end
  end

  private

  def adventure_participation_params
    params.permit(:character_id, :adventure_id)
  end
end
