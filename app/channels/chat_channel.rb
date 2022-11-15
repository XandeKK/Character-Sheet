class ChatChannel < ApplicationCable::Channel
  def subscribed
    if Adventure.find_by(server_name: params[:server_name])
      stream_from "chat_#{params[:server_name]}"
    else
      reject
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def message data
    ActionCable.server.broadcast("chat_#{params[:server_name]}", data)
  end

  def private_message data
    ActionCable.server.broadcast("chat_#{params[:server_name]}", data)
  end
  
  def put_me_on_chat data
    ActionCable.server.broadcast("chat_#{params[:server_name]}", data)
  end
  
  def character_exit data
    ActionCable.server.broadcast("chat_#{params[:server_name]}", data)
  end
  
  def want_characters data
    ActionCable.server.broadcast("chat_#{params[:server_name]}", data)
  end
end
