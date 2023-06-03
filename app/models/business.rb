class Business < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :user_favourites, dependent: :destroy
  has_many :favourited_users, through: :user_favourites, source: :user
  has_one_attached :photo

  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
