class Api::V1::PlaysController < ApplicationController
  before_action :set_play

  def update
    Play.update(@play.id, active: play_params[:active])
  end

  private

  def set_play
    player = current_user || AnonUser.where(nickname: params[:id])[0]
    @play = player.plays.where(game_id: params[:game_id])[0]
  end

  def play_params
    params.require(:play).permit(:active)
  end
end
