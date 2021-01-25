class GameJob < ApplicationJob
  queue_as :default

  def perform
    game_master = GameMaster.last
    unless game_master.running
      toggle_game_master(game_master)
      # Game Cycle
      while active_players
        # reset board
        helpers.new_game
        # Game Cycle
        until checkmate || stalemate
          timer_cycle
          make_move(tally_votes)
        end
      end
    end
    # Check in Task model if running is set to true
    toggle_game_master(game_master)
  end

  private

  def active_players
    Game.last.plays.where(active: true)
  end

  def checkmate
    # Check if checkmate condition

    # Send action cable to alert browser to new game condition
  end

  def stalemate
    # Check if checkmate condition

    # Send action cable to alert browser to new game condition
  end

  def toggle_game_master(game_master)
    game_master.running = !game_master.running
    game_master.save
  end

  def timer_cycle
    10.times do |count|
      sleep 1
      ActionCable.server.broadcast 'timer_channel', count
    end
  end

  def make_move
    #
  end

  def tally_votes
    # return voted on move
  end
end
