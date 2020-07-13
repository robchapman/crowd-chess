# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Cleaning database..."
Space.destroy_all
Piece.destroy_all
Play.destroy_all
User.destroy_all
Chat.destroy_all
Team.destroy_all
Board.destroy_all
Game.destroy_all
Move.destroy_all
puts "Clean!"

puts "Creating Teams..."
black = Team.create!(colour: 'black')
white = Team.create!(colour: 'white')
teams = [white, black]
puts "Created Teams!"

puts "Creating Game..."
game = Game.create!
puts "Created Game!"

puts "Creating Board..."
board = Board.new(game: game)
board.save!
puts "Created Board!"

puts "Creating Spaces"
spaces = []
(0..7).each do |row|
  spaces_row = []
  (0..7).each do |column|
    (row % 2) == (column % 2) ? space_team = white : space_team = black
    spaces_row << Space.create!(row: row, column: column, board: board, team: space_team)
  end
  spaces << spaces_row
end
puts "Created Spaces!"

puts "Creating Pieces and Chats..."
pieces = { white: {}, black: {} }
teams.each do |team|
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
  # Chat
  Chat.create!(game: game, team: team)
end
puts "Created Pieces and Chats!"

puts "Placing Pieces..."
# Place White at bottom always
# Black
# Back Row
spaces[0][0].piece = pieces[:black][:rooks][0]
spaces[0][1].piece = pieces[:black][:knights][0]
spaces[0][2].piece = pieces[:black][:bishops][0]
spaces[0][3].piece = pieces[:black][:king][0]
spaces[0][4].piece = pieces[:black][:queen][0]
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
spaces[7][3].piece = pieces[:white][:king][0]
spaces[7][4].piece = pieces[:white][:queen][0]
spaces[7][5].piece = pieces[:white][:bishops][1]
spaces[7][6].piece = pieces[:white][:knights][1]
spaces[7][7].piece = pieces[:white][:rooks][1]

spaces.each do |row|
  row.each do |space|
    space.save!
  end
end

puts "Placed Pieces!"

puts "Creating Users..."
rob = User.create!(email: 'robchapman94@gmail.com', password: 'password', nickname: 'rob', team: white)
puts "Created Users!"

puts "Creating Play of Game..."
Play.create!(user: rob, game: game)
puts "Playing Game"

