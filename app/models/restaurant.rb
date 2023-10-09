class Restaurant < ApplicationRecord
  has_one_attached :image
  has_many :likes
  has_many :comments
  belongs_to :customer
  belongs_to :genre

  validates :restaurant_name, presence: true
  validates :place, presence: true
  validates :food_name, presence: true
  validates :body, presence: true, length:{maximum:200}
  validates :price, presence: true
end
