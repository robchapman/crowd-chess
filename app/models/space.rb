class Space < ApplicationRecord
  belongs_to :board
  belongs_to :team
  belongs_to :piece, optional: true
end
