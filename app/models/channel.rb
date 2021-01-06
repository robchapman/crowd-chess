class Channel < ApplicationRecord
  belongs_to :game
  belongs_to :team
  has_many :messages
end
