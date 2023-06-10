class BusinessesController < ApplicationController
  # need to add logic for second location search bar
  def index
    @businesses = Business.all
    # created a sql query variable for readabilty
    sql_subquery = "name ILIKE :query OR category ILIKE :query"
    # conditional - so we do not run query if no instances exist
    if params[:query].present?
      # query: here is what would usually be ? in sql. We have simply named the placeholder
      @businesses = Business.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def show
    @business = Business.find(params[:id])
    @review = Review.new # @favourite = UserFavourite.new

    @marker = {
      lat: @business.latitude,
      lng: @business.longitude
    }
  end

  private

  # name, adress rating = boilerplate. To be changed later?
  # Do we need strong params if we are going to use a new/create method ?

  def business_params
    params.require(:business).permit(:name, :address, :rating, :photo)
  end
end
