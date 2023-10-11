class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image
  has_many :restaurants
  has_many :likes
  has_many :comments

  validates :name, presence: true
  validates :age, presence: true
  validates :body, length:{maximum:200}
  validates :email, presence: true, uniqueness: true

  def self.looks(search, word)
    if search == "perfect_match"
      @customers = Customer.where(name: word)
    elsif search == "partial_match"
      @customers = Customer.where("name LIKE?","%#{word}%")
    else
      @Customers = Customer.all
    end
  end

end
