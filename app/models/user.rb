class User < ApplicationRecord
  has_one_attached :photo
  
  has_many :chats, foreign_key: :user1_id, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :user_favourites, dependent: :destroy
  has_many :favourited_businesses, through: :user_favourites, source: :business

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
