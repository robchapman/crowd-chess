class Piece < ApplicationRecord
  belongs_to :team
  has_many :moves
  has_one :space

  validates :type, presence: true
  validates :team, presence: true
end
