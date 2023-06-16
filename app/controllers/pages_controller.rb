class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @ratings = []
    @recommended_array = []
    @wages = []
    @businesses = Business.all
    # created a sql query variable for readabilty
    sql_subquery = "name ILIKE :query OR category ILIKE :query"
    # conditional - so we do not run query if no instances exist
    if params[:query].present?
      # query: here is what would usually be ? in sql. We have simply named the placeholder
      @businesses = Business.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def profile #for users
    @user = current_user
    @favourites = @user.user_favourites
  end
end
