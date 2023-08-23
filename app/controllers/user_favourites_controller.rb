class UserFavouritesController < ApplicationController
  def index
    @favourites = current_user.user_favourites
  end

  def create
    @favourite = UserFavourite.new
    @favourite.user = current_user
    @favourite.business = Business.find(params[:business_id])
    @favourite.save

  end


  private

  def favourite_params
    params.require(:user_favourites).permit(:business)
  end
end
