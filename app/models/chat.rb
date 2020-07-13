class Chat < ApplicationRecord
  belongs_to :game
  belongs_to :team

  validates :game, presence: true
end
