class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :restaurant

  validates :comment, presence:, truelength: { minimum: 1, maximum: 200 }
end
