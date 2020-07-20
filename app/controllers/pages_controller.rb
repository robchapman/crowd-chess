class PagesController < ApplicationController
  def home
  end

  def play
    game = Game.last
    @board_grid = Array.new(10) { Array.new(10) }
    # Adding Labels
    @board_grid[0][1..8] = ('a'..'h').to_a
    @board_grid[9][1..8] = ('a'..'h').to_a
    @board_grid.each_with_index do |_, row_i|
      @board_grid.each_with_index do |_, col_i|
        if (col_i == 0 || col_i == 9) && (row_i > 0 && row_i < 9)
          @board_grid[row_i][col_i] = (9 - row_i).to_s
        end
      end
    end
    # Adding Spaces
    game.board.spaces.each do |space|
      @board_grid[space.row + 1][space.column + 1] = space
    end
  end
end
