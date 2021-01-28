require 'faker'

class PagesController < ApplicationController
  def home
  end

  def play
    # Get latest game for React Actions requests
    @game = Game.last

    if current_user # If User logged in
      player = current_user
    elsif !AnonUser.where(nickname: session[:anonNickname]).empty? # Users Anon nickname exists in DB
      player = AnonUser.where(nickname: session[:anonNickname])[0]
    elsif session[:anonNickname] # Nickname in session but no record
      player = AnonUser.create(nickname: session[:anonNickname])
    else # Generate new
      player = new_anon_user
    end
    @nickname = player.nickname

    # Create instance of play model if one does not exist for current game, assign team if needed
    if !Play.where(game: @game).where(player: player).empty?
      play_in_progress = Play.where(game: @game).where(player: player)[0]
      play_in_progress.active = true
      play_in_progress.save
      player_team = play_in_progress.team
    else
      player_team = new_player_team
      Play.create(team: player_team, player: player, active: true, game: @game)
    end

    @player_team = player_team.colour
    # Get intial Channel names state(should not change)
    # @channel_names = @game.channels.map { |channel| channel.name }
    @channel_names = ['general', @player_team]
    if @channel_names.include?('general')
      @selected_channel = 'general'
    else
      @selected_channel = @channel_names[0]
    end

    # # testing
    GameMaster.update(id: GameMaster.last.id, running: false)

    # # Ensure Game background job is running
    # BasicGameJob.perform_later unless GameMaster.last.running
  end

  private

  def new_player_team
    white = @game.teams.where(colour: 'white')[0]
    black = @game.teams.where(colour: 'black')[0]
    white_players = Play.where(active: true).where(team: white).count
    black_players = Play.where(active: true).where(team: black).count
    if white_players > black_players
      new_team = black
    elsif black_players > white_players
      new_team = white
    else
      new_team = rand(2).zero? ? white : black
    end
    new_team
  end

  def new_anon_user
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
    new_anon_user
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
