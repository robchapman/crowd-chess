class Message < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :anon_user, optional: true
  belongs_to :channel
end
