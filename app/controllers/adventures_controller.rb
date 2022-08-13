class AdventuresController < ApplicationController
  before_action :set_adventure, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_empty, only: [:show, :edit, :update, :destroy]

  def index
    @adventures = Adventure.where(user: current_user)
  end

  def show
    @allNpcs = Character.where(user: current_user, character_category_id: 3) # 3 == Npc
    @allEnemies = Character.where(user: current_user, character_category_id: 2) # 3 == Enemy
    @json = {}
  end

  def new
    @adventure = Adventure.new
  end

  def create
    @adventure = Adventure.new(adventure_params)

    @adventure.user = current_user
    @adventure.create_unique_name

    if @adventure.save
      redirect_to adventure_path(@adventure), notice: "Adventure created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @adventure.update(adventure_params)
      redirect_to adventure_path(@adventure), notice: "Adventure successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @adventure.destroy
      redirect_to adventures_path, notice: "Adventure successfully deleted"
    else
      redirect_to adventures_path, alert: "Could not delete."
    end
  end

  private

  def adventure_params
    params.require(:adventure).permit(:name, :password)
  end

  def redirect_if_empty
    redirect_to adventures_path, alert: "You do not have permission." if @adventure.nil?
  end

  def set_adventure
    begin
      @adventure = Adventure.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @adventure = nil
    else
      @adventure = nil if @adventure.user != current_user
    end
  end
end
