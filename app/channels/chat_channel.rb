class ChatChannel < ApplicationCable::Channel
  def subscribed
    if Adventure.find_by(server_name: params[:server_name])&.authenticate(params[:password])
      stream_from "chat_#{params[:server_name]}"
    else 
      reject
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive data
    ActionCable.server.broadcast("chat_#{params[:server_name]}", data)
  end
end
