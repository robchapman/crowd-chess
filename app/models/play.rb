class Play < ApplicationRecord
  belongs_to :game
  belongs_to :player, polymorphic: true
  belongs_to :team

  # Validations
  validates :game, uniqueness: { scope: :player }
end
