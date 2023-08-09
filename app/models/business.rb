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

  def recommended
    @recommended_array = []
    @businesses = Business.all

    @businesses.each do |business|
      business.reviews.each do |review|
        if review.recommended == true
          @recommended_array.push(review)
        end
      end
      unless business.reviews.empty?
        @wage = (@recommended_array .sum / business.reviews.length).ceil
      end
    end
  end

  def set_business(business_id)
    @business = Business.find(business_id)
  end
end
