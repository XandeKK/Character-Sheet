class PlayerChannel < ApplicationCable::Channel
  def subscribed
    if Adventure.find_by(unique_name: params[:unique_name])
      stream_from "player_#{params[:unique_name]}"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast params[:unique_name], data
  end
end
