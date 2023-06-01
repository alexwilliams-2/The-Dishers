class Business < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :user_favourites, dependent: :destroy

end
