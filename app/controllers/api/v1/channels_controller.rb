class Api::V1::ChannelsController < ApplicationController
  before_action :set_game

  def index
    channels = Channel.where("game_id = #{@game.id}").order(created_at: :asc)
    channels = channels.map do |channel|
      channel.name
    end
    render json: channels
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end
end
