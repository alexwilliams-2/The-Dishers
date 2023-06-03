class Business < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :user_favourites, dependent: :destroy
  has_one_attached :photo

end
