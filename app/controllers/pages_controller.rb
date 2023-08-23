class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @ratings = []
    @recommended_array = []
    @wages = []
    @businesses = Business.all

    sql_subquery = "name ILIKE :query OR category ILIKE :query"

    if params[:query].present?
      @businesses = Business.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def profile #for users
    @user = current_user
    @favourites = @user.user_favourites
  end
end
