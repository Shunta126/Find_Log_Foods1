class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image
  has_many :restaurants
  has_many :likes, dependent: :destroy
  has_many :comments
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_customers, through: :followers, source: :followed
  has_many :follower_customers, through: :followeds, source: :follower
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy


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

  def follow(customer_id)
    followers.create(followed_id: customer_id)
  end

  def unfollow(customer_id)
    followers.find_by(followed_id: customer_id).destroy
  end

  def following?(customer)
    following_customers.include?(customer)
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

end
