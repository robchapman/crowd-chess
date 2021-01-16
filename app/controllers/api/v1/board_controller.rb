class Api::V1::BoardController < ApplicationController
  before_action :set_game
  def index
    spaces = @game.board.spaces
    spaces_new = spaces.map do |space|
      {
        "colour": space.team.colour,
        "highlight": nil,
        "piece-type": (space.piece.type.downcase if space.piece),
        "piece-team": (space.piece.team.colour if space.piece),
        "selected": nil,
        "label": assign_label(space)
      }
    end
    render json: spaces_new
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def assign_label(space)
    return (8 - space.row) if space.column.zero?
    return (97 + space.column).chr if space.row == 7
  end
end
