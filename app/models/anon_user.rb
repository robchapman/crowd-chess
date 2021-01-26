class AnonUser < ApplicationRecord
  validates :nickname, uniqueness: true

  has_many :plays, as: :player
  has_many :messages, as: :author
end
