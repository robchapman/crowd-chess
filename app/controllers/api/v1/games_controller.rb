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
    ActionCable.server.broadcast 'game_current_game', new_game.id
    ActionCable.server.broadcast 'chat_current_game', new_game.id

    sleep 2

    ActionCable.server.broadcast 'game_board', 'Update Board'
    ActionCable.server.broadcast 'game_current_team', 'Update Current Team'
    ActionCable.server.broadcast 'chat_channels', 'Update Channels'
    ActionCable.server.broadcast 'chat_messages', 'Update Messages'
  end

  def latest
    render json: Game.last.id
  end
end


