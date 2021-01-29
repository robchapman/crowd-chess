class Api::V1::ChannelsController < ApplicationController
  before_action :set_game

  def index
    render json: ['general', player_colour]
  end

  private

  def player_colour
    player = current_user || AnonUser.find_by(nickname: session[:anonNickname])
    play = player.plays.find_by(game: @game)
    play.team.colour
  end


  def set_game
    @game = Game.find(params[:game_id])
  end
end
