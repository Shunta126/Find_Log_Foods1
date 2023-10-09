class Customer < ApplicationRecord
  has_one_attached :profile_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  validates :name, presence: true
  validates :age, presence: true
  validates :profile_image, presence: true
  validates :body, length:{maximum:200}
  validates :email, presence: true, uniqueness: true

end
