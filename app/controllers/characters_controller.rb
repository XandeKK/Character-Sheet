class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_empty, only: [:show, :edit, :update, :destroy]
  before_action :get_characters, only: [:show, :edit]

  def group
  end

  def index
    @characters = current_user.characters.select_of(params[:category].capitalize)
  end

  def show
  end

  def new
    @character_systems = CharacterSystem.all
  end

  def create
    @character = PathfinderCharacter::create_character(
      current_user,
      CharacterCategory.find_by(name: params[:category].capitalize),
      params[:system]
    )

    if @character
      redirect_to edit_character_path(category: params[:category], id: @character),
        notice: "#{params[:category].capitalize} created successfully!"
    else
      @character_systems = CharacterSystem.all
      render :new, alert: "#{params[:category].capitalize} not created successfully."
    end
  end

  def edit
  end

  def update
    if @character.update(PathfinderCharacter::character_params(params))
      save_image
      redirect_to character_path(category: params[:category], id: @character),
        notice: "#{params[:category].capitalize} successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @character.destroy
      redirect_to characters_path(category: params[:category]),
        notice: "#{params[:category].capitalize} successfully deleted!"
    else
      redirect_to characters_path(category: params[:category])
    end
  end

  def update_hp
    characters = params[:characters]
    PathfinderCharacter::update_hp(characters)
    head :ok
  end

  private

  def set_character
    @character = current_user.characters
      .pathfinder
      .find_by(id: params[:id])
  end

  def redirect_if_empty
    redirect_to characters_path(category: params[:category]),
      alert: "You do not have permission." if @character.nil?
  end

  def get_characters
    @characters_dropdown = Character
      .where(character_category: @character.character_category, user: current_user)
      .includes(:pathfinder_basic)
  end

  def save_image
    unless params[:character][:image].empty?
      @character.character_image.attach(data: params[:character][:image])
    end
  end
end
