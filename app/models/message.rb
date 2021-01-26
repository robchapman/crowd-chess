class Message < ApplicationRecord
  belongs_to :author, polymorphic: true
  belongs_to :channel
end
