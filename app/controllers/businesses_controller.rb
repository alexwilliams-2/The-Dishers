class BusinessesController < ApplicationController
  def index
    @businesses = Business.all
    sql_subquery = "name ILIKE :query OR category ILIKE :query"
    if params[:query].present?
      @businesses = Business.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def show
    @business = Business.find(params[:id])
  end

  private

  # name, adress rating = boilerplate. To be changed later?
  # Do we need strong params if we are going to use a new/create method ?

  def business_params
    params.require(:business).permit(:name, :address, :rating)
  end
end
