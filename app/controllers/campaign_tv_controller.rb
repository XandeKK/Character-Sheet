class CampaignTvController < ApplicationController
  def show
  end

  def create
    adventure = Adventure.find_by(unique_name: params[:unique_name], password: params[:password])

    respond_to do |format|
      if adventure.present?
        format.turbo_stream
        format.html { render html: "any", status: :ok }
      else
        format.html {render :show, status: :unprocessable_entity}
      end
    end
  end
end
