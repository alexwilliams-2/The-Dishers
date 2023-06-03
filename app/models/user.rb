class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :user_favourites, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
