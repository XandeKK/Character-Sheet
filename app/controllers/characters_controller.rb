class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_empty, only: [:show, :edit, :update, :destroy]
  before_action :get_characters, only: [:show, :edit]

  def show
  end

  def new
    @character_systems = CharacterSystem.all
  end

  def create
    @character = PathfinderCharacter::create_character(
      current_user,
      CharacterCategory.first,
      params[:system]
    )

    if @character
      redirect_to character_path(@character), notice: "Character created successfully!"
    else
      @character_systems = CharacterSystem.all
      render :new, alert: "Character not created successfully."
    end
  end

  def edit
  end

  def update
    if @character.update(PathfinderCharacter::character_params(params))
      save_image
      redirect_by_character_category(@character)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @character.destroy
      redirect_to player_path, notice: "Character successfully deleted!"
    else
      redirect_to player_path
    end
  end

  def update_hp
    characters = params[:characters]
    characters.each do |character|
      character_id = character[0]
      current_hp = character[1][:current_hp]
      temp_hp = character[1][:temp_hp]

      character_defense = Pathfinder::Defense.find_by(character_id: character_id)
      character_defense.update(
        current_hp: current_hp, temp_hp: temp_hp
      )
    end
    head :ok
  end

  private

  def set_character
    @character = current_user.characters
      .pathfinder
      .find_by(id: params[:id])
  end

  def redirect_if_empty
    redirect_to player_path, alert: "You do not have permission." if @character.nil?
  end
end
