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
end
