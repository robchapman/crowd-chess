class Team < ApplicationRecord
  has_many :users
  has_many :moves
  has_many :pieces
  has_one :chat
end
