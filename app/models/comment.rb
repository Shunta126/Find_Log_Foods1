class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :restaurant

  validates :comment, presence: true, length: {maximum: 150 }
end
