module ApplicationHelper
  def convertSpace(space)
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

  def get_notation(col, row)
    "#{(97 + col).chr}#{8 - row}"
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

  def get_FEN(spaces, game)
    [
      piece_placement(spaces),
      active_colour(game),
      castling,
      en_passant,
      halfmove(game),
      fullmove(game)
    ].join(' ')
  end

  def piece_placement(spaces)
    placement_string = ''
    spaces.each_with_index do |space, index|
      piece_type = space[:pieceType]
      piece_team = space[:pieceTeam]
      if piece_type
        letter = (piece_type == 'knight' ? 'n' : piece_type[0])
        letter = letter.upcase if piece_team == 'white'
      else
        letter = '0'
      end
      placement_string << letter
      placement_string << '/' if ((index + 1) % 8 == 0) && (index + 1 < spaces.length)
    end
    (1..8).to_a.reverse.each do |index|
      regx = Regexp.new('0' * index)
      placement_string.gsub!(regx, index.to_s)
    end
    placement_string
  end

  def active_colour(game)
    (game.moves.count + 1).odd? ? 'w' : 'b'
  end

  def castling
    'KQkq'
  end

  def en_passant
    '-'
  end

  def halfmove(game)
    # TODO: Should be halfmoves since last capture or pawn advance
    game.moves.count
  end

  def fullmove(game)
    game.moves.count / 2 + 1
  end
end
