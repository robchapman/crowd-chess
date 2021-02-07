class Api::V1::PlaysController < ApplicationController
  before_action :set_play

  def update
    Play.update(@play.id, active: play_params[:active])

    white = Game.last.teams.where(colour: 'white')[0]
    black = Game.last.teams.where(colour: 'black')[0]
    white_players = Play.where(active: true).where(team: white).count
    black_players = Play.where(active: true).where(team: black).count

    ActionCable.server.broadcast 'game_teamSizes', { white: white_players, black: black_players }

    helpers.flag
    puts "Play: #{@play.id} // #{@play.player.nickname} // #{@play.team.colour} // switched to: #{!@play.active}"
    puts "black players: #{black_players}"
    puts "white players: #{white_players}"
    helpers.flag
  end

  def beacon
    Play.update(@play.id, active: play_params[:active])

    white = Game.last.teams.where(colour: 'white')[0]
    black = Game.last.teams.where(colour: 'black')[0]
    white_players = Play.where(active: true).where(team: white).count
    black_players = Play.where(active: true).where(team: black).count

    ActionCable.server.broadcast 'game_teamSizes', { white: white_players, black: black_players }

    helpers.flag
    puts "Play: #{@play.id} // #{@play.player.nickname} // #{@play.team.colour} // switched to: #{!@play.active}"
    puts "black players: #{black_players}"
    puts "white players: #{white_players}"
    helpers.flag
  end

  def show
    render json: @play
  end

  private

  def set_play
    player = current_user || AnonUser.find_by(nickname: session[:anonNickname])
    @play = player.plays.where(game_id: params[:game_id])[0]
  end

  def play_params
    params.require(:play).permit(:active)
  end
end
