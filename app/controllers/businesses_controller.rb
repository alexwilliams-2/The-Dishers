class BusinessesController < ApplicationController
  # need to add logic for second location search bar
  # need to add logic for second location search bar
  def index
    @ratings = []
    @recommended_array = []
    @wages = []
    @businesses = Business.all

    # @average_rating = (@businesses.reviews.sum(:rating) / @businesses.reviews.length).ceil.to_i

    @businesses = @businesses.where(category: params[:category]) if params[:category].present?
    # @businesses = @businesses.where(reviews: { rating: params[:rating] }) if params[:rating].present? business.reviews.each do |review|
    #   "#{pluralize (@ratings.sum / business.reviews.length).ceil}"
    # end

    @businesses = @businesses.where(reviews: { rating: params[:rating] }) if params[:raiting].present?

    # created a sql query variable for readabilty
    sql_subquery = "name ILIKE :query OR category ILIKE :query"
    # conditional - so we do not run query if no instances exist
    if params[:query].present?
      # query: here is what would usually be ? in sql. We have simply named the placeholder
      @businesses = Business.where(sql_subquery, query: "%#{params[:query]}%")
    end

    @markers = @businesses.geocoded.map do |business|
      {
        lat: business.latitude,
        lng: business.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {business: business}),
        marker_html: render_to_string(partial: "marker")
      }
    end

    # respond_to do |format| #for the filters
    #   format.html
    #   format.js
    # end
  end

  def show
    @business = Business.where(id: params[:id]) #.find(params[:id]) was changed to .where(id: params[:id]). To use .geocoded.map, we need to iterate over an array, so business had to be wrapped to create the array.
    @review = Review.new # @favourite = UserFavourite.new
    @wages = []

    @markers = @business.geocoded.map do |business|
      {
        lat: business.latitude,
        lng: business.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {business: business}),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  private

  # name, adress rating = boilerplate. To be changed later?
  # Do we need strong params if we are going to use a new/create method ?

  def business_params
    params.require(:business).permit(:name, :address, :rating, :photo)
  end
end
