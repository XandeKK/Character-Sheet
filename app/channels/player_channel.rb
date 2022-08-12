class PlayerChannel < ApplicationCable::Channel
  def subscribed
    if Adventure.find_by(unique_name: params[:unique_name])
      stream_from "player_#{params[:unique_name]}"
    end
  end

  def unsubscribed
  end

  def receive(data)
    if data["act"] == "takePlayer"
      ActionCable.server.broadcast("gm_" + params[:unique_name], data)
    elsif data["act"] == "rollDice"
      ActionCable.server.broadcast params[:unique_name], data
    elsif data["act"] == "playerLeaves"
      ActionCable.server.broadcast("gm_" + params[:unique_name], data)
    elsif data["act"] == "updateLife"
      ActionCable.server.broadcast("gm_" + params[:unique_name], data)
    end
  end
end
