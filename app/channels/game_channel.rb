class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_#{params[:state]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
