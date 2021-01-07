class AnonUser < ApplicationRecord
  validates :nickname, uniqueness: true
end
