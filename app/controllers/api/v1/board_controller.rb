class Api::V1::BoardController < ApplicationController
  before_action :set_game
  def index
    # spaces = sort_spaces(@game.board.spaces)
    spaces = helpers.sort_spaces(@game.board.spaces).map do |space|
      helpers.convertSpace(space)
    end
    render json: { board: spaces, FEN: helpers.get_FEN(spaces, @game) }
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end
end
