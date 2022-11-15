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

  def roll data
    ActionCable.server.broadcast("tv_#{params[:server_name]}", data)
  end

  def put_me_on_adventure data
    ActionCable.server.broadcast("adventure_#{params[:server_name]}", data)
  end

  def character_exit data
    ActionCable.server.broadcast("adventure_#{params[:server_name]}", data)
    ActionCable.server.broadcast("character_#{params[:server_name]}", data)
  end

  def update_hp data
    ActionCable.server.broadcast("adventure_#{params[:server_name]}", data)
  end
end
