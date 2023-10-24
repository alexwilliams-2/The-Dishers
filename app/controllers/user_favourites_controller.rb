class UserFavouritesController < ApplicationController
  def index
    authorize @favourites
    @favourites = current_user.user_favourites.uniq
  end

  # def create
  #   @favourite = UserFavourite.new
  #   @favourite.user = current_user
  #   @favourite.business = Business.find(params[:business_id])
  #   authorize @favourite
  #   @favourite.save

  # end
  def toggle_like
    business_id = params[:business_id]
    @favourite = current_user.user_favourites.find_by(business_id: business_id)

    if @favourite
      authorize @favourite
      @favourite.destroy
    else
      @favourite = UserFavourite.new
      @favourite.user = current_user
      @favourite.business = Business.find(business_id)
      authorize @favourite
      @favourite.save
    end
  end

  private

  def favourite_params
    params.require(:user_favourites).permit(:business)
  end


end
