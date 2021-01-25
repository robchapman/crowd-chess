class Api::V1::MovesController < ApplicationController
  before_action :set_game

  def index
    # TODO: Return all moves taken on game for record display feature
  end

  def create
    # TODO if move not successfully created return message that will prevent
    # piece from moving on front end
    puts "GAME ID IS :"
    puts @game.id
    start_space = Space.find(move_params[:start])
    end_space = Space.find(move_params[:end])
    piece = start_space.piece
    team = piece.team
    Move.create(
      start_id: move_params[:start],
      end_id: move_params[:end],
      team: team,
      piece: piece,
      game: @game
    )

    clicked = helpers.convertSpace(end_space)
    selected = helpers.convertSpace(start_space)

    # Actually change Space - Piece associations
    start_space.piece = nil
    start_space.save
    end_space.piece = piece
    end_space.save

    spaces = helpers.sort_spaces(@game.board.spaces).map do |space|
      helpers.convertSpace(space)
    end

    ActionCable.server.broadcast 'game_channel', "Update Board"
    ActionCable.server.broadcast 'timer_channel', 5

    render json: {
      FEN: helpers.get_FEN(spaces, @game),
      clicked: clicked,
      selected: selected
    }.to_json
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def move_params
    params.permit(:start, :end)
  end
end

