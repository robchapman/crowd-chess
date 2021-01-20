class Api::V1::BoardController < ApplicationController
  before_action :set_game
  def index
    # spaces = sort_spaces(@game.board.spaces)
    spaces = sort_spaces(@game.board.spaces).map do |space|
      {
        "id": space.id,
        "notation": get_notation(space.column, space.row),
        "colour": space.team.colour,
        "pieceType": (space.piece.type.downcase if space.piece),
        "pieceTeam": (space.piece.team.colour if space.piece),
        "selected": nil,
        "highlight": nil,
        "label": assign_label(space)
      }
    end
    render json: { board: spaces, FEN: get_FEN(spaces) }
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def assign_label(space)
    return ['1', 'a'] if space.row == 7 && space.column.zero?
    return [(8 - space.row).to_s, nil] if space.column.zero?
    return [nil, (97 + space.column).chr] if space.row == 7
    return [nil, nil]
  end

  def sort_spaces(spaces)
    sorted_spaces = []
    8.times do |row|
      current_row = spaces.filter { |space| space.row == row }
      sorted_spaces += current_row.sort_by! { |space| space.column }
    end
    sorted_spaces
  end

  def get_notation(col, row)
    "#{(97 + col).chr}#{8 - row}"
  end

  def get_FEN(spaces)
    [
      piece_placement(spaces),
      active_colour,
      castling,
      en_passant,
      halfmove,
      fullmove
    ].join(' ')
  end

  def piece_placement(spaces)

    placement_string = ''
    spaces.each do |space, index|

    end

    "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"
  end

  def active_colour
    'w'
  end

  def castling
    'KQkq'
  end

  def en_passant
    '-'
  end

  def halfmove
    # TODO: Should be halfmoves since last capture or pawn advance
    white_id = @game.board.spaces.first.team.id
    black_id = @game.board.spaces.second.team.id
    Move.where({ team_id: [white_id, black_id] }).count
  end

  def fullmove
    black_id = @game.board.spaces.second.team.id
    Move.where({ team_id: [black_id] }).count + 1
  end
end
