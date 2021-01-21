class Game < ApplicationRecord
  has_many :plays
  has_many :users, through: :plays
  has_one :board
  has_many :channels
  has_many :moves
end

