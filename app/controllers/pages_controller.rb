require 'faker'

class PagesController < ApplicationController
  def home
  end

  def play
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
end
