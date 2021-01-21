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
    spaces.each_with_index do |space, index|
      piece_type = space[:pieceType]
      piece_team = space[:pieceTeam]
      if piece_type
        letter = piece_type == 'Knight' ? 'N' : piece_type[0]
        letter.downcase! if piece_team == 'black'
      else
        letter = '0'
      end
      placement_string << letter
      placement_string << '/' if ((index + 1) % 8 == 0) && (index + 1 < spaces.length)
    end
    8.times do |index|
      regx = Regexp.new('0' * (index + 1))
      placement_string.gsub!(regx, (index + 1).to_s)
    end
    placement_string

    # "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"
    # string = "rnbqkbnr/0pp0ppp0/p00p0000/0000000p/00000000/00000000/PPPPPPPP/RNBQKBNR"
  end

  def active_colour
    # white_id = @game.board.spaces.first.team.id
    # black_id = @game.board.spaces.second.team.id
    white_moves = Team.where("colour = 'white'")[0].moves.count
    black_moves = Team.where("colour = 'black'")[0].moves.count
    white_moves > black_moves ? 'b' : 'w'
  end

  def castling
    'KQkq'
  end

  def en_passant
    '-'
  end

  def halfmove
    # TODO: Should be halfmoves since last capture or pawn advance
    white_moves = Team.where("colour = 'white'")[0].moves.count
    black_moves = Team.where("colour = 'black'")[0].moves.count
    white_moves + black_moves
  end

  def fullmove
    Team.where("colour = 'black'")[0].moves.count + 1
  end
end
