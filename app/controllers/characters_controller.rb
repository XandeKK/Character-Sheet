class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_empty, only: [:show, :edit, :update, :destroy]

  def index
    @player = CharacterCategory.find_by_name("Player")
    @characters = Character.where(user: current_user, character_category: @player)
  end

  def show
  end

  def edit
    @character_categories = CharacterCategory.all
    render partial: "edit", locals: { character: @character }
  end

  def create
    @character = Character.new

    if @character.create_character current_user
      redirect_to character_path(@character), notice: "Character created successfully"
    else
      @player = CharacterCategory.find_by_name("Player")
      @characters = Character.where(user: current_user, character_category: @player)

      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @character.update(character_params)
      render partial: "display", locals: { character: @character }
    else
      @character_categories = CharacterCategory.all
      render partial: 'edit', locals: { character: @character } , status: :unprocessable_entity
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
