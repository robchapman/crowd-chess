class Api::V1::MovesController < ApplicationController
  def index
    render json: { "hi": "test" }

  end

  def create
    puts "CONTROLLER MOVE METHOD"
  end
end
