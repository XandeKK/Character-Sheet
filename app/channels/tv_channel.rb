class TvChannel < ApplicationCable::Channel
  def subscribed
    p params
    if Adventure.find_by(server_name: params[:server_name])&.authenticate(params[:password])
      stream_from "tv_#{params[:server_name]}"
    else 
      reject
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
