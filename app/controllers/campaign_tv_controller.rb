class CampaignTvController < ApplicationController
  def show
  end

  def create
    adventure = Adventure.find_by(unique_name: params[:unique_name], password: params[:password])

    respond_to do |format|
      if adventure.present?
        format.turbo_stream { render "campaign_tv/create", status: :ok}
      else
        format.turbo_stream { render "campaign_tv/error_create", status: :unprocessable_entity}
      end
    end
  end
end
