class BasicGameJob < ApplicationJob
  queue_as :default
  include ApplicationHelper

  def perform
    @game_master = GameMaster.last
    label
    toggle_running # Set Gamemaster to run

    # # Game Cycle
    # while active_players
    #   # reset board
    #   # helpers.new_game
    #   # Game Cycle
    #   until gameover
    #     # timer_cycle
    #     # make_move(tally_votes)
    #   end
    # end
    toggle_running # Turn Gamemaster off once there are no active players
    # Check in Task model if running is set to true
  end

  private

  def active_players
    current_plays = Game.last.plays
    last_active = current_plays.where(active: false).order('updated_at DESC')[0].updated_at
    # Return true if there are active players or someone went inactive
    # less than 2 mins ago
    current_plays.where(active: true) || Time.zone.now - last_active < 120
  end

  def gameover
    # Check if gameover condition
      @game_master.gameover
    # Send action cable to alert browser to new game condition
  end

  def toggle_running
    @game_master.running = !@game_master.running
    @game_master.save
  end

  def timer_cycle
    ActionCable.server.broadcast 'timer_channel', 10
    sleep 10
  end

  def make_move
    # Broadcast on game channel to update front_end
    ActionCable.server.broadcast 'game_channel', "Update Board"

  end

  def tally_votes
    # return voted on move
  end

  def label
    puts '/////////////////////////////////////////////////////////////////////'
    puts '/////////////////////////////////////////////////////////////////////'
    puts '/////////////////////////////////////////////////////////////////////'
    puts '/////////////////////////////////////////////////////////////////////'
    puts '/////////////////////////////////////////////////////////////////////'
    puts '/////////////////////////////////////////////////////////////////////'
    puts '/////////////////////////////////////////////////////////////////////'
    puts '/////////////////////////////////////////////////////////////////////'
    puts '/////////////////////////////////////////////////////////////////////'
    puts '/////////////////////////////////////////////////////////////////////'
    puts '/////////////////////////////////////////////////////////////////////'
    puts '/////////////////////////////////////////////////////////////////////'
  end
end
