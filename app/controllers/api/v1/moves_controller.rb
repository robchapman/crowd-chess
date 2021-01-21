class Api::V1::MovesController < ApplicationController
  before_action :set_game

  def index
    # TODO: Return all moves taken on game for record display feature
  end

  def create
    # TODO if move not successfully created return message that will prevent
    # piece from moving on front end
    piece = Space.find(move_params[:start]).piece
    team = piece.team
    Move.create(
      start_id: move_params[:start],
      end_id: move_params[:end],
      team: team,
      piece: piece,
      game: @game
    )
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def move_params
    params.permit(:start, :end)
  end
end

