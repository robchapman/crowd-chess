require 'faker'

class PagesController < ApplicationController
  def home
  end

  def play
    # Get latest game for React Actions requests
    @game = Game.last

    # Get intial Channel names state(should not change)
    @channel_names = @game.channels.map { |channel| channel.name }
    if @channel_names.include?('general')
      @selected_channel = 'general'
    else
      @selected_channel = @channel_names[0]
    end

    # If no User logged create or username in session
    # generate Anon Username and store in session
    time_num = (Time.now.to_f * 10_000_000).to_i
    Faker::Config.random = time_num
    puts Faker::
    # Buil Board
    board
  end

  private

  def board
    # Produce board array to be rendered(with labels)
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
    @game.board.spaces.each do |space|
      @board_grid[space.row + 1][space.column + 1] = space
    end
  end
end
