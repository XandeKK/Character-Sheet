class TvChannel < ApplicationCable::Channel
  def subscribed
    if Adventure.find_by(unique_name: params[:unique_name])
      stream_from params[:unique_name]
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
  end
end
