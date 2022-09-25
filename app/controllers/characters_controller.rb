class CharactersController < ApplicationController
  before_action :set_character, only: [:edit, :update, :destroy]
  before_action :redirect_if_empty, only: [:edit, :update, :destroy]

  def show
    @character = current_user.characters
      .pathfinder
      .find_by(id: params[:id])
    redirect_if_empty
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
    if @character.character_system.name == "Pathfinder"
      if @character.update(PathfinderCharacter::character_params(params))
        save_image
        redirect_to character_path(@character), notice: "Character successfully updated!"
      else
        render :edit, status: :unprocessable_entity
      end
    else

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
    @character = current_user.characters.find_by(id: params[:id])
  end

  def redirect_if_empty
    redirect_to player_path, alert: "You do not have permission." if @character.nil?
  end

  def save_image
    unless params[:character][:image].empty?
      @character.character_image.attach(data: params[:character][:image])
    end
  end
end
