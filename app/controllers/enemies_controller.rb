class EnemiesController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_empty, only: [:show, :edit, :update, :destroy]

  def index
    @enemies = current_user.characters
      .select("characters.id, pathfinder_basics.name")
      .joins(:character_category, :pathfinder_basic)
      .where("character_category.name": "Enemy")
      .includes(character_image_attachment: :blob)
  end

  def show
  end

  def new
    @character_systems = CharacterSystem.all
  end

  def create
    @character = PathfinderCharacter::create_character(
      current_user,
      CharacterCategory.find_by(name: "Enemy"),
      params[:system]
    )

    if @character
      redirect_to enemy_path(@character), notice: "Enemy created successfully!"
    else
      @character_systems = CharacterSystem.all
      render :new, alert: "Enemy not created successfully."
    end
  end

  def edit
  end

  def update
    if @character.character_system.name == "Pathfinder"
      if @character.update(PathfinderCharacter::character_params(params))
        redirect_to enemy_path(@character), notice: "Enemy successfully updated!"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if @character.destroy
      redirect_to enemies_path, notice: "Enemy successfully deleted!"
    else
      redirect_to enemies_path
    end
  end

  private

  def set_character
    @character = current_user.characters.find_by(id: params[:id])
  end

  def redirect_if_empty
    redirect_to enemies_path, alert: "You do not have permission." if @character.nil?
  end
end
