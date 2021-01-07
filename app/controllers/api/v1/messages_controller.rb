class Api::V1::MessagesController < ApplicationController
  before_action :set_channel
  before_action :set_anon_user, only: :create

  def index
    messages = Message.where("channel_id = #{@channel.id}").order(created_at: :asc)
    messages_new = messages.map do |message|
      {
        "id": message.id,
        "author": message.user&.nickname || message.anon_user&.nickname || "anon",
        "content": message.content,
        "created_at": message.created_at
      }
    end
    render json: messages_new
  end

  def create
    # TODO: Validations on message content format
    # TODO: allow anon chatting
    message = Message.create(content: message_params[:content], user: current_user, channel: @channel, anon_user: @anon_user)
    message_new = {
      "id": message.id,
      "author": message.user&.nickname || message.anon_user&.nickname || "anon",
      "content": message.content,
      "created_at": message.created_at
    }
    ActionCable.server.broadcast 'chat_channel',
      "id": message.id,
      "author": message.user&.nickname || message.anon_user&.nickname || "anon",
      "content": message.content,
      "created_at": message.created_at
    render json: message_new
  end

  private

  def set_channel
    @channel = Channel.find_by(name: params[:channel_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def publish_message(message)
    {
      "id": message.id,
      "author": message.user&.nickname || message.anon_user&.nickname || "anon",
      "content": message.content,
      "created_at": message.created_at
    }
  end

  def set_anon_user
    @anon_user = AnonUser.find_by(nickname: cookies[:anonNickname])
  end
end
