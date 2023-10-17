class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image
  has_many :restaurants
  has_many :likes, dependent: :destroy
  has_many :comments

  validates :name, presence: true, length: {maximum: 20 }
  validates :age, presence: true, length: {maximum: 105 }
  validates :body, presence: true, length:{maximum:200}
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

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "ゲストユーザー"
      customer.age = "20"
      customer.body = "変更は会員登録後に行えます！"
    end
  end

end
