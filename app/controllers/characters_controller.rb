class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy, :update_life]
  before_action :redirect_if_empty, only: [:show, :edit, :update, :destroy]

  def index
    @player = CharacterCategory.find_by_name("Player")
    @characters = Character.where(user: current_user, character_category: @player)
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
      @player = CharacterCategory.find_by_name("Player")
      @characters = Character.where(user: current_user, character_category: @player)

      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @character.update(character_params)
      @character.character_image.attach(data: params[:character][:character_image])
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
    characterList = JSON.parse params["characterList"]
    characterList.each do |character|
      @character = Character.find_by(id: character[0], user: current_user)
      currentHp = character[1]["currentHp"]
      temporary = character[1]["temporary"]

      statistic = JSON.parse(@character.statistic)
      statistic["character"]["hitPoints"]["currentHp"] = currentHp
      statistic["character"]["hitPoints"]["temporary"] = temporary

      @character.update!(statistic: statistic.to_json)
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
    params.require(:character).permit(:name, :statistic, :character_category_id, character_image: :data )
  end

  def redirect_if_empty
    redirect_to characters_path, alert: "You do not have permission." if @character.nil?
  end

  def set_character
    @character = Character.find_by(id: params[:id], user: current_user)
  end

  def set_character_json
    @character_json = JSON.parse @character.statistic
    @character_json = @character_json["character"]
  end
end
