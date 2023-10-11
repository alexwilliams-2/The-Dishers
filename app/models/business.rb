class Business < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_many :reviews, dependent: :destroy
  has_many :user_favourites, dependent: :destroy

  has_many :favourited_users, through: :user_favourites, source: :user
  has_one_attached :photo

  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  include Filterable

  def calculate_average_rating
    @ratings = []
    set_business(self.id)

    @business.reviews.each do |review|
      @ratings.push(review.rating)
    end

    unless @business.reviews.empty?
      @rating = (@ratings.sum / @business.reviews.length).ceil
    end
  end

  def calculate_average_wage
    @wages = []
    set_business(self.id)

    @business.reviews.each do |review|
      @wages.push(review.wage)
    end
    unless @business.reviews.empty?
      ActionController::Base.helpers.number_to_currency((@wages.sum / @business.reviews.length), unit: "£")
    end
  end

  def calculate_recommended
    @recommended_array = []
    set_business(self.id)

    @business.reviews.each do |review|
      if review.recommended == true
        @recommended_array.push(review)
      end
    end

    recommended_count = @recommended_array.length

    unless @business.reviews.empty?
      recommended_count
    end
  end

  def set_business(business_id)
    @business = Business.where(id: business_id).first
  end
end
