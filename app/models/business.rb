class Business < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_many :reviews, dependent: :destroy
  has_many :user_favourites, dependent: :destroy
  # favourited user = user_favourites.
  has_many :favourited_users, through: :user_favourites, source: :user
  has_one_attached :photo

  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  # def average_rating
  #   @ratings = []
  #   @businesses = Business.all
  #   @businesses.each do |business|
  #     business.reviews.each do |review|
  #       @ratings.push(review.rating)
  #       # average_rating = (total_rating / review.length).ceil
  #       @rating = (@ratings.sum / business.reviews.length).ceil
  #     end
  #   end
  # end
end
