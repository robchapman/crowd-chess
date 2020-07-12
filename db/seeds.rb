# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
game = Game.create!

board = Board.new(game: game)
board.save!

(0..7).each do |row|
  (0..7).each do |column|
    Space.create!(row: row, column: column, board: board)
  end
end

