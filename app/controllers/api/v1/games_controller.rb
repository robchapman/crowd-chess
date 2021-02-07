class Api::V1::GamesController < ApplicationController
  def create
    prev_game = Game.last
    helpers.new_game
    new_game = Game.last

    # Transition Plays
    prev_plays = prev_game.plays.where(active: true)
    white_players = 0
    black_players = 0
    prev_plays.each do |play|
      new_team = new_game.teams.find_by("colour = '#{play.team.colour}'")
      Play.create(team: new_team,
                  player: play.player,
                  active: true,
                  game: new_game)
      Play.update(play.id, active: false)
      white_players += 1 if play.team.colour == 'white'
      black_players += 1 if play.team.colour == 'black'
    end

    # Get FEN of Updated Board config
    spaces = Space.includes({ piece: :team }, :team).where(board: new_game.board)
    spaces = helpers.sort_spaces(spaces).map do |space|
      helpers.convertSpace(space)
    end
    new_fen = helpers.get_FEN(spaces, new_game)

    # Update Front ends
    ActionCable.server.broadcast 'game_current_game', new_game.id
    ActionCable.server.broadcast 'chat_current_game', new_game.id
    ActionCable.server.broadcast 'game_board', { board: spaces, FEN: new_fen }
    ActionCable.server.broadcast 'game_teamSizes', { white: white_players, black: black_players }

    # sleep 2

    ActionCable.server.broadcast 'game_current_team', 'Update Current Team'
    ActionCable.server.broadcast 'chat_channels', 'Update Channels'
    ActionCable.server.broadcast 'chat_messages', 'Update Messages'
  end

  def latest
    render json: Game.last.id
  end
end


