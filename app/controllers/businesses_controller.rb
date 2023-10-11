class BusinessesController < ApplicationController

  def index
    @ratings = []
    @recommended_array = []
    @wages = []
    all_businesses = policy_scope(Business).all

    filtering_params = params.slice(:category, :rating, :wage)

    all_businesses = Business.filter(filtering_params)

    all_businesses


    sql_subquery = "(category ILIKE :query OR name ILIKE :query)"
    location_sqlquery = "address ILIKE :region_query"

    if params[:query].present? && params[:region_query].present?
      all_businesses = all_businesses.where("#{sql_subquery} AND #{location_sqlquery}",
      query: "%#{params[:query]}%", region_query: "%#{params[:region_query]}%")

    elsif params[:query].present? && !params[:region_query].present?
      all_businesses = all_businesses.where(sql_subquery, query: "%#{params[:query]}%")

    elsif !params[:query].present? && params[:region_query].present?
      all_businesses = all_businesses.where(location_sqlquery, region_query: "%#{params[:region_query]}%")
    end

    @pagy, @businesses = pagy(all_businesses, items: 5)

    @markers = all_businesses.geocoded.map do |business|
      {
        lat: business.latitude,
        lng: business.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { business: business }),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def show
    @business = Business.where(id: params[:id])
    authorize @business
    @review = Review.new
    @wages = []
    @ratings = []
    @user_review = params[:user_review].to_i if params[:user_review].present?


    @markers = @business.geocoded.map do |business|
      {
        lat: business.latitude,
        lng: business.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {business: business}),
        marker_html: render_to_string(partial: "marker")
      }
    end
    @business = @business.first
  end

  def average_wage
    @business = Business.where(id: params[:id]).first
    @average_wage = @business.calculate_average_wage
  end

  def average_rating
    @business = Business.where(id: params[:id]).first
    @average_rating = @business.calculate_average_raiting
  end

  def recommended
    @business = Business.where(id: params[:id]).first
    @recommended = @business.calculate_recommended
  end

  private


  def business_params
    params.require(:business).permit(:name, :address, :rating, :photo)
  end
end
