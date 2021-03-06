class Api::V1::MessagesController < ApplicationController
  before_action :set_channel
  before_action :set_anon_user, only: :create

  def index
    messages = Message.includes(:author).where("channel_id = #{@channel.id}").order(created_at: :asc)
    messages_new = messages.map do |message|
      {
        'id': message.id,
        'author': message.author&.nickname || 'anon',
        'content': message.content,
        'created_at': message.created_at
      }
    end
    render json: messages_new
  end

  def create
    # TODO: Validations on message content format
    # TODO: allow anon chatting
    author = current_user || @anon_user
    message = Message.create(content: message_params[:content], author: author, channel: @channel)
    message_new = {
      'id': message.id,
      'author': message.author&.nickname || 'anon',
      'content': message.content,
      'created_at': message.created_at
    }
    ActionCable.server.broadcast 'chat_messages',
      'id': message.id,
      'author': message.author&.nickname || 'anon',
      'content': message.content,
      'created_at': message.created_at
    render json: message_new
  end

  private

  def set_channel
    @channel = Channel.where(name: params[:channel_id]).order(created_at: :desc)[0]
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def publish_message(message)
    {
      'id': message.id,
      'author': message.author&.nickname || 'anon',
      'content': message.content,
      'created_at': message.created_at
    }
  end

  def set_anon_user
    @anon_user = AnonUser.find_by(nickname: session[:anonNickname])
  end
end
