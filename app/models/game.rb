class Game < ApplicationRecord
  has_many :plays
  has_many :users, through: :plays
  has_one :board
end
