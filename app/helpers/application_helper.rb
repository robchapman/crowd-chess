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

  def new_game
    game = Game.create
    teams = generate_teams(game)
    board = Board.create(game: game)
    spaces = generate_spaces(board, teams)
    pieces = generate_pieces(teams)
    place_pieces(spaces, pieces)
    generate_channels(game, game.teams)
  end

  def generate_teams(game)
    Team.create!(colour: 'general', game: game)
    {
      white: Team.create(colour: 'white', game: game),
      black: Team.create(colour: 'black', game: game)
    }
  end

  # Returns 2D array with board spaces using supplied teams
  def generate_spaces(board, teams)
    spaces = []
    (0..7).each do |row|
      spaces_row = []
      (0..7).each do |column|
        space_team = ((row % 2) == (column % 2) ? teams[:white] : teams[:black])
        spaces_row << Space.create!(
          row: row,
          column: column,
          board: board,
          team: space_team
        )
      end
      spaces << spaces_row
    end
    spaces
  end

  def generate_pieces(teams)
    pieces = { white: {}, black: {} }
    teams.each do |key, team|
      # Pawns
      pieces[team.colour.to_sym][:pawns] = []
      8.times do
        pieces[team.colour.to_sym][:pawns] << Pawn.create!(team: team)
      end
      # Rooks
      pieces[team.colour.to_sym][:rooks] = []
      2.times do
        pieces[team.colour.to_sym][:rooks] << Rook.create!(team: team)
      end
      # Knights
      pieces[team.colour.to_sym][:knights] = []
      2.times do
        pieces[team.colour.to_sym][:knights] << Knight.create!(team: team)
      end
      # Bishops
      pieces[team.colour.to_sym][:bishops] = []
      2.times do
        pieces[team.colour.to_sym][:bishops] << Bishop.create!(team: team)
      end
      # Queens
      pieces[team.colour.to_sym][:queen] = []
      pieces[team.colour.to_sym][:queen] << Queen.create!(team: team)
      # Kings
      pieces[team.colour.to_sym][:king] = []
      pieces[team.colour.to_sym][:king] << King.create!(team: team)
    end
    pieces
  end

  def place_pieces(spaces, pieces)
    # Place White at bottom always
    # Black
    # Back Row
    spaces[0][0].piece = pieces[:black][:rooks][0]
    spaces[0][1].piece = pieces[:black][:knights][0]
    spaces[0][2].piece = pieces[:black][:bishops][0]
    spaces[0][3].piece = pieces[:black][:queen][0]
    spaces[0][4].piece = pieces[:black][:king][0]
    spaces[0][5].piece = pieces[:black][:bishops][1]
    spaces[0][6].piece = pieces[:black][:knights][1]
    spaces[0][7].piece = pieces[:black][:rooks][1]
    # Front Row
    spaces[1].each_with_index do |space, index|
      space.piece = pieces[:black][:pawns][index]
    end
    # White
    # Front Row
    spaces[6].each_with_index do |space, index|
      space.piece = pieces[:white][:pawns][index]
    end
    # Back Row
    spaces[7][0].piece = pieces[:white][:rooks][0]
    spaces[7][1].piece = pieces[:white][:knights][0]
    spaces[7][2].piece = pieces[:white][:bishops][0]
    spaces[7][3].piece = pieces[:white][:queen][0]
    spaces[7][4].piece = pieces[:white][:king][0]
    spaces[7][5].piece = pieces[:white][:bishops][1]
    spaces[7][6].piece = pieces[:white][:knights][1]
    spaces[7][7].piece = pieces[:white][:rooks][1]

    spaces.each do |row|
      row.each do |space|
        space.save
      end
    end
  end

  def generate_channels(game, teams)
    teams.each do |team|
      Channel.create(game: game, team: team, name: team.colour)
    end
    general_team = Team.find_by(game: game, colour: 'general')
    return unless general_team

    Channel.create(game: game, team: general_team, name: general_team.colour)
  end
end
