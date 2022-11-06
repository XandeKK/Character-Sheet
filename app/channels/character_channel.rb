class CharacterChannel < ApplicationCable::Channel
  def subscribed
    if Adventure.find_by(server_name: params[:server_name])&.authenticate(params[:password])
      stream_from "character_#{params[:server_name]}"
    else
      reject
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive data
    if data["act"] == "putMeOnAdventure"
      ActionCable.server.broadcast("adventure_#{params[:server_name]}", data)
    elsif data["act"] == "characterExit"
      ActionCable.server.broadcast("adventure_#{params[:server_name]}", data)
      ActionCable.server.broadcast("character_#{params[:server_name]}", data)
    elsif data["act"] == "updateHp"
      ActionCable.server.broadcast("adventure_#{params[:server_name]}", data)
    elsif data["act"] == "rollDice"
      ActionCable.server.broadcast("tv_#{params[:server_name]}", data)
    end
  end
end
