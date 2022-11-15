class AdventureChannel < ApplicationCable::Channel
  def subscribed
    stream_from "adventure_#{params[:server_name]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def want_players data
    ActionCable.server.broadcast("character_#{params[:server_name]}", data)
  end

  def roll data
    ActionCable.server.broadcast("tv_#{params[:server_name]}", data)
  end
end
