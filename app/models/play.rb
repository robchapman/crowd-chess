class Play < ApplicationRecord
  belongs_to :game
  belongs_to :user
  belongs_to :team

  # Validations
  validates :game, uniqueness: { scope: :user }
end
