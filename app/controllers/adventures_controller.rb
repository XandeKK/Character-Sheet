class AdventuresController < ApplicationController
  before_action :set_adventure, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_empty, only: [:show, :edit, :update, :destroy]

  def index
    @adventures = Adventure.where(user: current_user)
  end

  def show
  end

  def new
    @adventure = Adventure.new
  end

  def create
    @adventure = current_user.adventures.new(adventure_params)
    
    @adventure.create_server_name

    if @adventure.save
      redirect_to adventure_path(@adventure), notice: "Adventure created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @adventure.update(adventure_params)
      redirect_to adventure_path(@adventure), notice: "Adventure successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @adventure.destroy
      redirect_to adventures_path, notice: "Adventure successfully deleted!"
    else
      redirect_to adventures_path, alert: ""
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
    @adventure = current_user.adventures.find_by(id: params[:id])
  end
end
