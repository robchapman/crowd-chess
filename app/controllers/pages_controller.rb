class PagesController < ApplicationController
  def home
  end

  def play
    game = Game.last
    @board_grid = Array.new(8) { Array.new(8) }
    game.board.spaces.each do |space|
      @board_grid[space.row][space.column] = space
    end
  end
end
