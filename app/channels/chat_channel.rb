class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:state]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
