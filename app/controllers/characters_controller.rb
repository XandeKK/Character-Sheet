class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy, :update_life]
  before_action :redirect_if_empty, only: [:show, :edit, :update, :destroy]

  def index
    @characters = Character.where(user: current_user, character_category_id: 1) # 1 == Player
  end

  def show
    set_character_json
  end

  def edit
    @character_categories = CharacterCategory.all
  end

  def create
    @character = Character.new
    category = params[:category]

    if @character.create_character current_user, category
      redirect_to character_path(@character), notice: "Character created successfully"
    else
      @characters = Character.where(user: current_user, character_category_id: 1) # 1 == Player

      render :index, status: :unprocessable_entity
    end
  end

  def update
    character_image = params[:character][:image]
    if @character.update(character_params)
      @character.character_image.attach(data: character_image) if character_image.present?
      redirect_to character_path(@character), notice: "Character successfully updated"
    else
      @character_categories = CharacterCategory.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    category = @character.character_category.name
    if @character.destroy
      if category == "Player"
        redirect_to characters_path, notice: "Character successfully deleted"
      elsif category == "Npc"
        redirect_to npcs_path, notice: "Character successfully deleted"
      else
        redirect_to enemies_path, notice: "Character successfully deleted"
      end
    else
      redirect_to characters_path, alert: "Could not delete."
    end
  end

  def update_all_life
    characters = JSON.parse params["characters"]
    characters.each do |character|
      character_tmp = Character.find_by(id: character[0], user: current_user)
      character_tmp.update_life character
    end
    render plain: "OK", status: :ok
  end

  def sign_up
    adventure = Adventure.find_by(unique_name: params[:unique_name], password: params[:password])

    respond_to do |format|
      if adventure.present?
        format.turbo_stream { render "characters/sign_up", status: :ok }
      else
        format.turbo_stream { render "characters/error_sign_up", status: :unprocessable_entity }
      end
    end
  end

  private

  def character_params
    params.require(:character).permit(:name, :statistic, :character_category_id )
  end

  def redirect_if_empty
    redirect_to characters_path, alert: "You do not have permission." if @character.nil?
  end

  def set_character
    begin
      @character = Character.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @character = nil
    else
      @character = nil if @character.user != current_user
    end
  end

  def set_character_json
    @character_json = JSON.parse @character.statistic
    @character_json = @character_json["character"]
  end
end
