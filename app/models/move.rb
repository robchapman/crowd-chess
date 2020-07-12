class Move < ApplicationRecord
  belongs_to :start, class_name: 'Space'
  belongs_to :end, class_name: 'Space'
  belongs_to :team
  belongs_to :piece
end
