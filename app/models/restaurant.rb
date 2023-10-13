class Restaurant < ApplicationRecord
  has_one_attached :image
  has_many :likes, dependent: :destroy
  has_many :comments
  belongs_to :customer
  belongs_to :genre

  validates :restaurant_name, presence: true, length: {maximum: 50 }
  validates :place, presence: true, length: {maximum: 30 }
  validates :food_name, presence: true, length: {maximum: 50 }
  validates :body, presence: true, length:{maximum:200}
  validates :price, presence: true, length: {maximum: 50 }

  def self.looks(search, word, range)
    if range == "店舗名"
      if search == "perfect_match"
        @restaurants = Restaurant.where(restaurant_name: word)
      elsif search == "partial_match"
        @restaurants = Restaurant.where("restaurant_name LIKE?","%#{word}%")
      else
        @restaurant = Restaurant.all
      end
    else
      if search == "perfect_match"
        @restaurants = Restaurant.where(place: word)
      elsif search == "partial_match"
        @restaurans = Restaurant.where("place LIKE?","%#{word}%")
      else
        @restaurants = Restaurant.all
      end
    end
  end

  def liked_by?(customer)
   likes.exists?(customer_id: customer.id)
  end

end
