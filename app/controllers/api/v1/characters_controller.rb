class Api::V1::CharactersController < Api::V1::ApiController
  before_action :set_character, except: [:index]
	def index
    characters = @current_user.characters
    characters_names = []

    characters.each do |character| 
      characters_names << character.slug
    end
    render json: { names: characters_names }, status: :ok
	end

	def show
    render json: @character.statistic, status: :ok
	end

  private

  def set_character
    begin
      @character = @current_user.characters.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unprocessable_entity
    end
  end
end
