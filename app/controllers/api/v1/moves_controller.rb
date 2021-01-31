class Api::V1::MovesController < ApplicationController
  before_action :set_game

  def index
    # TODO: Return all moves taken on game for record display feature
  end

  def create
    # TODO if move not successfully created return message that will prevent
    # piece from moving on front end
    moves = []
    moves << build_move(move_params[:start], move_params[:end])

    white = @game.teams.where(colour: 'white')[0]
    black = @game.teams.where(colour: 'black')[0]
    white_players = Play.where(active: true).where(team: white).count
    black_players = Play.where(active: true).where(team: black).count

    if move_params[:comp_moves] && (white_players.zero? || black_players.zero?)
      notation = move_params[:comp_moves].sample
      start_notation = notation[:start]
      end_notation = notation[:end]
      comp_move_start = Space.find_by(column: (start_notation[0].ord - 97), row: -(start_notation[1].to_i - 8))
      comp_move_end = Space.find_by(column: (end_notation[0].ord - 97), row: -(end_notation[1].to_i - 8))
      moves << build_move(comp_move_start.id, comp_move_end.id)
    end

    # Get FEN of Updated Board config
    spaces = Space.includes({ piece: :team }, :team).where(board: @game.board)
    spaces = helpers.sort_spaces(spaces).map do |space|
      helpers.convertSpace(space)
    end
    new_fen = helpers.get_FEN(spaces, @game)
    # Update board and broadcast
    ActionCable.server.broadcast 'game_board', { board: spaces, FEN: new_fen }

    render json: {
      FEN: new_fen,
      moves: moves
    }.to_json

  end

  private

  def build_move(start_id, end_id)
    start_space = Space.find(start_id)
    end_space = Space.find(end_id)
    piece = start_space.piece
    team = piece.team

    Move.create(
      start_id: start_id,
      end_id: end_id,
      team: team,
      piece: piece,
      game: @game
    )

    start_space_cnvtd = helpers.convertSpace(start_space)
    end_space_cnvtd = helpers.convertSpace(end_space)
    move = { start: start_space_cnvtd, end: end_space_cnvtd }

    # Actually change Space - Piece associations
    start_space.piece = nil
    start_space.save
    end_space.piece = piece
    end_space.save

    move
  end

  def set_game
    @game = Game.find(params[:game_id])
  end

  def move_params
    params.require(:move).permit(:start, :end, comp_moves: [:start, :end])
  end

  def flag
    puts '/////////////////////////////////////////////////////////////////////'
    puts '/////////////////////////////////////////////////////////////////////'
    puts '/////////////////////////////////////////////////////////////////////'
    puts '/////////////////////////////////////////////////////////////////////'
  end
end
