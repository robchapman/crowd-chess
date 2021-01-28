class Api::V1::GamesController < ApplicationController
  def create
    prev_game = Game.last
    helpers.new_game
    new_game = Game.last

    # Tranition Plays
    prev_plays = prev_game.plays.where(active: true)
    prev_plays.each do |play|
      Play.create(team: play.team, player: play.player, active: true, game: new_game)
    end

    # Update Front ends
    sleep 5

    ActionCable.server.broadcast 'game_channel', ['CURRENT_GAME']
    ActionCable.server.broadcast 'chat_channel', ['CURRENT_GAME']
    ActionCable.server.broadcast 'game_channel', ['BOARD', 'PLAYER_TEAM']
    ActionCable.server.broadcast 'chat_channel', ['CHANNELS', 'MESSAGES']
  end

  def latest
    render json: Game.last.id
  end
end

# {type: 'CURRENT_GAME', payload: new_game}



