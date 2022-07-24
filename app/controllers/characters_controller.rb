class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_empty, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @character = Character.new
  end

  def create
    @character = Character.new(character_params)

    @character.user = current_user

    if @character.save
      redirect_to character_path(@character), notice: "Character created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @character.update(character_params)
      redirect_to character_path(@character), notice: "Character successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @character.destroy
      redirect_to characters_path, notice: "Character successfully deleted"
    else
      redirect_to characters_path, alert: "Could not delete."
    end
  end

  private

  def character_params
    params.require(:character).permit(:name, :statistic, :character_category_id)
  end

  def redirect_if_empty
    redirect_to characters_path, alert: "You do not have permission." if @character.nil?
  end

  def set_character
    @character = Character.find_by(id: params[:id], user: current_user)
  end
end
