class Api::V1::BoardController < ApplicationController
  before_action :set_game
  def index
    # spaces = sort_spaces(@game.board.spaces)
    spaces = sort_spaces(@game.board.spaces).map do |space|
      {
        "id": space.id,
        "colour": space.team.colour,
        "highlight": nil,
        "pieceType": (space.piece.type.downcase if space.piece),
        "pieceTeam": (space.piece.team.colour if space.piece),
        "selected": nil,
        "label": assign_label(space)
      }
    end
    render json: spaces
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def assign_label(space)
    return ['1', 'a'] if space.row == 7 && space.column.zero?
    return (8 - space.row) if space.column.zero?
    return (97 + space.column).chr if space.row == 7
  end

  def sort_spaces(spaces)
    sorted_spaces = []
    8.times do |row|
      current_row = spaces.filter { |space| space.row == row }
      sorted_spaces += current_row.sort_by! { |space| space.column }
    end
    sorted_spaces
  end
end
