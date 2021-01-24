require 'faker'

class PagesController < ApplicationController
  def home
  end

  def play
    # For testing
    # new_game

    # Get latest game for React Actions requests
    @game = Game.last

    # If no User logged create or username in session
    # generate Anon Username and store in session
    if current_user.nil? && session[:anonNickname].nil?
      count = 0
      new_anon_user = AnonUser.new(nickname: generate_username)
      until new_anon_user.save
        if count > 10
          new_anon_user = AnonUser.new(nickname: generate_username)
        else
          count += 1
          new_anon_user = AnonUser.new(nickname: generate_username_numbered)
        end
      end
      session[:anonNickname] = new_anon_user.nickname
    end

    @nickname = current_user || session[:anonNickname] || "anon"

    # Assign User to a team

    # Get intial Channel names state(should not change)
    @channel_names = @game.channels.map { |channel| channel.name }
    if @channel_names.include?('general')
      @selected_channel = 'general'
    else
      @selected_channel = @channel_names[0]
    end
  end

  private

  def generate_username
    verb = Faker::Verb.past_participle
    animal = Faker::Creature::Animal.name
    "#{verb}-#{animal}"
  end

  def generate_username_numbered
    verb = Faker::Verb.past_participle
    animal = Faker::Creature::Animal.name
    number = Faker::Number.number(digits: 2)
    "#{verb}-#{animal}-#{number}"
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
  end
end
