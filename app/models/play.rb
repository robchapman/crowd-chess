class Play < ApplicationRecord
  belongs_to :game
  belongs_to :user

  # Validations
  validates :game, uniqueness: { scope: :user }
end
