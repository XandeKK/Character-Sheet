class CharactersController < ApplicationController
  before_action :set_character, only: [:edit, :update, :destroy]
  before_action :redirect_if_empty, only: [:edit, :update, :destroy]

  def show
    @character = current_user.characters
      .includes(:pathfinder_spells, :pathfinder_melees, :pathfinder_items, :pathfinder_feats, :pathfinder_languages, :pathfinder_rangeds, :pathfinder_skills, :pathfinder_focus_spells, :pathfinder_weapon_proficiencies, :pathfinder_innate_spells, :pathfinder_notes)
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
