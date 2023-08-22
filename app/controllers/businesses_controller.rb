class BusinessesController < ApplicationController

  def index
    @ratings = []
    @recommended_array = []
    @wages = []
    @businesses = Business.all

    @businesses = @businesses.where(category: params[:category]) if params[:category].present?

    if params[:rating].present?
      result = []
      @businesses.each do |business|
        if (business.reviews.sum(:rating) / business.reviews.count).ceil == params[:rating].to_i
          result.push(business.id)
        end
      end
      @businesses = Business.where(id: result)
    end

    if params[:wage].present?
      result = []
      @businesses.each do |business|
        average_wage = (business.reviews.sum(:wage) / business.reviews.count).to_f
        if average_wage >= params[:wage].to_f && average_wage <= params[:wage].to_f + 1
          result.push(business.id)
        end
      end
      @businesses = Business.where(id: result)
    end

    sql_subquery = "name ILIKE :query OR category ILIKE :query"

    if params[:query].present?
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


  end

  def show
    @business = Business.where(id: params[:id])
    @review = Review.new
    @wages = []
    @ratings = []

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


  def business_params
    params.require(:business).permit(:name, :address, :rating, :photo)
  end
end
