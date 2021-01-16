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
    # Build Board
    # board_build

    @nickname = current_user || session[:anonNickname] || "anon"
  end

  private

  def board_build
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
end
