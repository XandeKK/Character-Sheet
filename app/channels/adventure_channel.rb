class AdventureChannel < ApplicationCable::Channel
  def subscribed
    stream_from "adventure_#{params[:server_name]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive data
    if data["act"] == "wantPlayers"
      ActionCable.server.broadcast("character_#{params[:server_name]}", data)
    elsif data["act"] == "rollDice"
      ActionCable.server.broadcast("tv_#{params[:server_name]}", data)
    end
  end
end
