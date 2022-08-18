class JsonWebTokenController < ApplicationController
  def create
    @token = JsonWebToken.encode(user_id: current_user.id)
    if @token.present?
      respond_to do |format|
        format.turbo_stream { render "json_web_token/create", status: :ok}
      end
    end
  end
end
