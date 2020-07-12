class Piece < ApplicationRecord
  belongs_to :team
  has_many :moves
end
