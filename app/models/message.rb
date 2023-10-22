class Message < ApplicationRecord
  belongs_to :customer
  belongs_to :room

  validates :message, presence: true, length: { maximum: 200 }
end
