class AdventuresController < ApplicationController
  before_action :set_adventure, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_empty, only: [:show, :edit, :update, :destroy]

  def index
    @adventures = Adventure.where(user: current_user)
  end

  def show
    @characters = Character.where(user: current_user)
  end

  def new
    @adventure = Adventure.new
  end

  def create
    @adventure = Adventure.new(adventure_params)

    @adventure.user = current_user
    @adventure.create_unique_name

    if @adventure.save
      redirect_to adventure_path(@adventure), notice: t(:"adventure created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @adventure.update(adventure_params)
      redirect_to adventure_path(@adventure), notice: t(:"adventure updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @adventure.destroy
      redirect_to adventures_path, notice: t(:"adventure deleted")
    else
      redirect_to adventures_path, alert: t(:"error deleted")
    end
  end

  private

  def adventure_params
    params.require(:adventure).permit(:name, :password)
  end

  def redirect_if_empty
    redirect_to adventures_path, alert: t(:"not have permission") if @adventure.nil?
  end

  def set_adventure
    begin
      @adventure = current_user.adventures.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @adventure = nil
    end
  end
end
