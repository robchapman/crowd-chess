class Move < ApplicationRecord
  belongs_to :start, class_name: 'Space'
  belongs_to :end, class_name: 'Space'
  belongs_to :team
  belongs_to :piece
  belongs_to :game

  validates :start, presence: true
  validates :end, presence: true
  validates :team, presence: true
  validates :piece, presence: true
end
